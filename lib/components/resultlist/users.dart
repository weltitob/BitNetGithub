import 'dart:async';
import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/auth/storeIONdata.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/components/dialogsandsheets/dialogs.dart';
import 'package:BitNet/components/items/userresult.dart';
import 'package:BitNet/models/IONdata.dart';
import 'package:BitNet/models/userdata.dart';
import 'package:BitNet/pages/auth/ionloadingscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/backbone/helper/loaders.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UsersList extends StatefulWidget {
  final Function() loadingION;
  final Function() showError;

  const UsersList({Key? key,
    required this.loadingION,
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
    var timer = Timer(Duration(milliseconds: 50), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List userdids = [];

  Future<List<IONData>> getIONDatafromLocalStorage() async {
    // Assuming you have a method to get all stored IONData from secure storage
    print("GetIONdataFromLocalStorage...");
    return await getAllStoredIonData();
  }

  Future<List<UserData>> getUserDatafromFirebase(List<String> dids) async {
    print("Fetching firebase Data for user...");
    List<UserData> userDataList = [];

    for (String did in dids) {
      // Fetch user document from Firestore using the did
      DocumentSnapshot doc = await usersCollection.doc(did).get();

      // Convert the document data to UserData and add to the list
      userDataList.add(UserData.fromDocument(doc));
    }
    print(userDataList);
    return userDataList;
  }

  PageController pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppTheme.cardPadding * 0.75),
          child: Container(
            height: AppTheme.cardPadding * 8,
            child: FutureBuilder<List<IONData>>(
              future: getIONDatafromLocalStorage(),
              builder: (context, ionSnapshot) {
                if (!ionSnapshot.hasData) {
                  return SizedBox(
                      height: AppTheme.cardPadding * 5,
                      child: Center(child: dotProgress(context)));
                }
                List<String> dids = ionSnapshot.data!.map((ionData) => ionData.did).toList();

                return FutureBuilder<List<UserData>>(
                  future: getUserDatafromFirebase(dids),
                  builder: (context, userDataSnapshot) {
                    if (!userDataSnapshot.hasData) {
                      return SizedBox(
                          height: AppTheme.cardPadding * 5,
                          child: Center(child: dotProgress(context)));
                    }
                    List<UserData> all_userresults = userDataSnapshot.data!;
                    if (all_userresults.length == 0) {
                      return searchForFilesAnimation(_searchforfilesComposition);
                    }
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: PageView.builder(
                            controller: pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _selectedindex = index;
                              });
                            },
                            itemCount: all_userresults.length,
                            itemBuilder: (context, index) {
                              final userData = all_userresults[index];
                              var _scale = _selectedindex == index ? 1.0 : 0.85;

                              final ionData = ionSnapshot.data!.firstWhere((ionData) => ionData.did == userData.did);
                              return TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: _scale, end: _scale),
                                curve: Curves.ease,
                                duration: Duration(milliseconds: 350),
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    child: child,
                                  );
                                },
                                child: Center(
                                  child: UserResult(
                                    onTap: () async {
                                      try{
                                        widget.loadingION();
                                        await Auth().signIn(
                                          userData.did,
                                          ionData.publicIONKey,
                                          ionData.privateIONKey,
                                          userData.username,
                                        );
                                      } catch(e){
                                        print("Second widgetloading should be called...");
                                        widget.loadingION();
                                        widget.showError();
                                        throw Exception("Error trying to sign in: $e");
                                      }
                                    },
                                    userData: userData,
                                    onDelete: () async {
                                    await deleteUserFromStoredIONData(userData.did);
                                    setState(() {
                                      all_userresults.removeAt(index);
                                    });
                                  },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: AppTheme.elementSpacing,),
                        Center(
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: all_userresults.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: AppTheme.colorBitcoin,
                              dotColor: AppTheme.glassMorphColorLight,
                            ),
                          ),
                        ),
                      ],
                    );
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
                      duration: Duration(milliseconds: 1000),
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
          SizedBox(height: AppTheme.elementSpacing,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 3),
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
