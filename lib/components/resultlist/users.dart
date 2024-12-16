import 'dart:async';
import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/key_services/hdwalletfrommnemonic.dart';
import 'package:bitnet/backbone/helper/key_services/sign_challenge.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';
import 'package:bitnet/components/items/userresult.dart';
import 'package:bitnet/models/keys/privateionkey.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';

class UsersList extends StatefulWidget {
  final Function() showError;

  const UsersList({
    Key? key,
    required this.showError,
  }) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>
    with SingleTickerProviderStateMixin {
  late final Future<LottieComposition> _searchforfilesComposition;
  bool _visible = false;
  var _selectedindex = 0;

  @override
  void initState() {
    super.initState();
    _searchforfilesComposition =
        loadComposition('assets/lottiefiles/search_for_files.json');
    updatevisibility();
  }

  void updatevisibility() async {
    await _searchforfilesComposition;
    var timer = Timer(const Duration(milliseconds: 50), () {
      setState(() {
        _visible = true;
      });
    });
  }

  loginButtonPressed(PrivateData privateData) async {
    try {
      HDWallet hdWallet = HDWallet.fromMnemonic(privateData.mnemonic);
      print("Login for user ${hdWallet.pubkey} pressed");
      print("Privatekey: ${hdWallet.privkey}");

      final logger = Get.find<LoggerService>();

      String challengeData = "Saved User SecureStorage Challenge";

      String signatureHex = await signChallengeData(
          hdWallet.privkey, hdWallet.pubkey, challengeData);

      logger.d('Generated signature hex: $signatureHex');

      await Auth().signIn(ChallengeType.securestorage_login, privateData,
          signatureHex, context);
    } catch (e) {
      print("Second widgetloading should be called...");
      widget.showError();
      throw Exception("Error trying to sign in: $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  List userdids = [];

  Future<List<PrivateData>> getIONDatafromLocalStorage() async {
    // Assuming you have a method to get all stored IONData from secure storage
    print("Get Private Data from secure storage...");
    dynamic storeddata = await getAllStoredIonData();
    print(storeddata);
    return storeddata;
  }

  Future<List<UserData>> getUserDatafromFirebase(List<String> dids) async {
    print("Fetching firebase Data for user...");
    List<UserData> userDataList = [];

    try {
      for (String did in dids) {
        try {
          print("Fetching user with did $did from Firebase...");
          // Fetch user document from Firestore using the did
          DocumentSnapshot doc = await usersCollection.doc(did).get();

          // Convert the document data to UserData and add to the list
          userDataList.add(UserData.fromDocument(doc));
        } catch (e) {
          print("Error trying to fetch user with did $did from Firebase: $e");
          // If desired, handle removal of local user data here:
          await deleteUserFromStoredIONData(did);
          print("User with did $did removed from local storage");
          throw Exception(
              "An error occured trying to fetch user with did $did from Firebase: $e");
        }
      }
      print(userDataList);
      return userDataList;
    } catch (e) {
      print("Error trying to fetch user data from Firebase: $e");
      throw Exception(
          "An error occured trying to fetch user data from Firebase: $e");
    }
  }

  PageController pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppTheme.cardPadding * 0.75),
          child: Container(
            height: AppTheme.cardPadding * 8,
            child: FutureBuilder<List<PrivateData>>(
              future: getIONDatafromLocalStorage(),
              builder: (context, ionSnapshot) {
                if (!ionSnapshot.hasData) {
                  return SizedBox(
                      height: AppTheme.cardPadding * 4,
                      child: Center(child: dotProgress(context)));
                }
                List<String> dids = ionSnapshot.data!
                    .map((ionData) =>
                        HDWallet.fromMnemonic(ionData.mnemonic).pubkey)
                    .toList();

                return FutureBuilder<List<UserData>>(
                  future: getUserDatafromFirebase(dids),
                  builder: (context, userDataSnapshot) {
                    if (!userDataSnapshot.hasData) {
                      return SizedBox(
                          height: AppTheme.cardPadding * 4,
                          child: Center(child: dotProgress(context)));
                    }
                    List<UserData> all_userresults = userDataSnapshot.data!;
                    if (all_userresults.isEmpty) {
                      return searchForFilesAnimation(
                          _searchforfilesComposition);
                    }

                    // Check if we have more than 10 users
                    if (all_userresults.length > 10) {
                      // Show a vertical ScrollView with all users
                      return VerticalFadeListView(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: all_userresults.map((userData) {
                                      final privateData = ionSnapshot.data!
                                          .firstWhere((ionData) =>
                                              HDWallet.fromMnemonic(
                                                      ionData.mnemonic)
                                                  .pubkey ==
                                              userData.did);
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: UserResult(
                                          onTap: () async {
                                            await loginButtonPressed(
                                                privateData);
                                          },
                                          userData: userData,
                                          onDelete: () async {
                                            await deleteUserFromStoredIONData(
                                                userData.did);
                                            setState(() {
                                              all_userresults.remove(userData);
                                            });
                                          },
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      // Show the PageView indicator as before
                      return Column(
                        children: <Widget>[
                          Container(
                            height: AppTheme.cardPadding * 3.5,
                            child: Expanded(
                              child: PageView.builder(
                                controller: pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    _selectedindex = index;
                                  });
                                },
                                itemCount: all_userresults.length,
                                itemBuilder: (context, index) {
                                  final userData =
                                      all_userresults.reversed.toList()[index];
                                  var _scale =
                                      _selectedindex == index ? 1.0 : 0.85;

                                  final privateData = ionSnapshot.data!
                                      .firstWhere((ionData) =>
                                          HDWallet.fromMnemonic(
                                                  ionData.mnemonic)
                                              .pubkey ==
                                          userData.did);
                                  return TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                        begin: _scale, end: _scale),
                                    curve: Curves.ease,
                                    duration: const Duration(milliseconds: 350),
                                    builder: (context, value, child) {
                                      return Transform.scale(
                                        scale: value,
                                        child: child,
                                      );
                                    },
                                    child: Center(
                                      child: UserResult(
                                        onTap: () async {
                                          await loginButtonPressed(privateData);
                                        },
                                        userData: userData,
                                        onDelete: () async {
                                          await deleteUserFromStoredIONData(
                                              userData.did);
                                          setState(() {
                                            all_userresults.removeAt(
                                                all_userresults.length -
                                                    1 -
                                                    index); // calculate original index
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppTheme.cardPadding,
                          ),
                          Center(
                            child: CustomIndicator(
                                pageController: pageController,
                                count: all_userresults.length),
                          ),
                        ],
                      );
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget searchForFilesAnimation(dynamic comp) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: AppTheme.cardPadding * 6,
            width: AppTheme.cardPadding * 6,
            child: FutureBuilder(
              future: comp,
              builder: (context, snapshot) {
                dynamic composition = snapshot.data;
                if (composition != null) {
                  return FittedBox(
                    fit: BoxFit.fitHeight,
                    child: AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 1000),
                      child: Lottie(composition: composition),
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.transparent,
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: AppTheme.elementSpacing,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: AppTheme.cardPadding * 2),
            child: Text(
              "It appears that you haven't added any users to your device yet.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
