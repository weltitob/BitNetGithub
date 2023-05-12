import 'dart:async';

import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/auth/storeIONdata.dart';
import 'package:BitNet/backbone/cloudfunctions/loginion.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/components/items/userresult.dart';
import 'package:BitNet/models/IONdata.dart';
import 'package:BitNet/models/userdata.dart';
import 'package:BitNet/pages/settings/invitation_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:BitNet/backbone/cloudfunctions/gettransactions.dart';
import 'package:BitNet/backbone/helper/helpers.dart';
import 'package:BitNet/backbone/helper/loaders.dart';
import 'package:BitNet/backbone/streams/gettransactionsstream.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:provider/provider.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList>
    with SingleTickerProviderStateMixin {
  late final Future<LottieComposition> _searchforfilesComposition;
  bool _visible = false;

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


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppTheme.cardPadding * 0.75),
          child: Container(
            height: AppTheme.cardPadding * 10,
            child: FutureBuilder<List<IONData>>(
              future: getIONDatafromLocalStorage(),
              builder: (context, ionSnapshot) {
                if (!ionSnapshot.hasData) {
                  return SizedBox(
                      height: AppTheme.cardPadding * 3,
                      child: Center(child: dotProgress(context)));
                }
                List<String> dids = ionSnapshot.data!.map((ionData) => ionData.did).toList();

                return FutureBuilder<List<UserData>>(
                  future: getUserDatafromFirebase(dids),
                  builder: (context, userDataSnapshot) {
                    if (!userDataSnapshot.hasData) {
                      return SizedBox(
                          height: AppTheme.cardPadding * 3,
                          child: Center(child: dotProgress(context)));
                    }
                    List<UserData> all_userresults = userDataSnapshot.data!;
                    if (all_userresults.length == 0) {
                      return searchForFilesAnimation(_searchforfilesComposition);
                    }
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: all_userresults.length,
                      itemBuilder: (context, index) {
                        final userData = all_userresults[index];
                        final ionData = ionSnapshot.data!.firstWhere((ionData) => ionData.did == userData.did);
                        return UserResult(
                          onTap: () {
                            Auth().signIn(
                              userData.did,
                              ionData.publicIONKey,
                              ionData.privateIONKey,
                              userData.username,
                            );
                          },
                          userData: userData,
                        );
                      },
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
    return Column(
      children: [
        SizedBox(
          height: AppTheme.cardPadding * 2,
        ),
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
        Container(
          margin: EdgeInsets.all(AppTheme.cardPadding),
          child: Text(
            "Es scheint, als hättest du bisher noch keine User auf deinem Gerät angemeldet.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
