import 'package:BitNet/backbone/auth/auth.dart';
import 'package:BitNet/backbone/cloudfunctions/loginion.dart';
import 'package:BitNet/backbone/helper/databaserefs.dart';
import 'package:BitNet/backbone/helper/loaders.dart';
import 'package:BitNet/backbone/helper/theme.dart';
import 'package:BitNet/backbone/routes/showprofile.dart';
import 'package:BitNet/components/items/userresult.dart';
import 'package:BitNet/models/userdata.dart';
import 'package:BitNet/models/verificationcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvitationSettingsPage extends StatefulWidget {
  const InvitationSettingsPage({Key? key}) : super(key: key);

  @override
  State<InvitationSettingsPage> createState() => _InvitationSettingsPageState();
}

class _InvitationSettingsPageState extends State<InvitationSettingsPage> {
  late final Stream<List<VerificationCode>> invitekeystream;
  final user = Auth().currentUser;

  Stream<List<VerificationCode>> _getInvitationKeys() {
    return codesCollection
        .where("issuer", isEqualTo: user!.uid)
        .snapshots()
        .map((event) => event.docs
        .map((e) => VerificationCode.fromMap(e.data(), e.id))
        .toList());
  }

  @override
  void initState() {
    invitekeystream = _getInvitationKeys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: StreamBuilder(
        stream: invitekeystream,
        builder: (context, AsyncSnapshot<List<VerificationCode>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return Container(
                height: 400, child: Center(child: CircularProgressIndicator()));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppTheme.cardPadding),
                child: Text(
                  "Our service is currently in beta and "
                      "limited to invited users. You can share these invitation "
                      "keys with your friends and family!",
                  style: Theme.of(context).textTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final verificationkey = snapshot.data![index];
                  return _KeyItem(verificationkey: verificationkey);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _KeyItem extends StatefulWidget {
  final VerificationCode verificationkey;

  const _KeyItem({
    required this.verificationkey,
  });

  @override
  State<_KeyItem> createState() => _KeyItemState();
}

class _KeyItemState extends State<_KeyItem> {
  Future<QuerySnapshot>? userFuture;
  String _free = "free";

  @override
  initState() {
    super.initState();
    getUser(widget.verificationkey.receiver);
  }

  getUser(String userId) {
    Future<QuerySnapshot> user = usersCollection.where("did", isEqualTo: userId).get();
    setState(() {
      userFuture = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.verificationkey.used
          ? () {
        showProfile(context, profileId: widget.verificationkey.receiver);
      }
          : () {
        //copy the key
        _free = "copied";
        //change free text to copied code und dann abändern
        Clipboard.setData(
            ClipboardData(text: widget.verificationkey.code));
        setState(() {});
      },
      child: Container(
        height: AppTheme.cardPadding * 2,
        margin: EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding * 1.5,
        ).copyWith(
          bottom: AppTheme.cardPadding,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: AppTheme.cardRadiusMid,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Row(
          children: <Widget>[
            widget.verificationkey.used
                ? buildUserResult()
                : Icon(
              Icons.key,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              size: AppTheme.iconSize,
            ),
            SizedBox(width: AppTheme.cardPadding),
            Text(widget.verificationkey.code,
                style: Theme.of(context).textTheme.titleSmall),
            Spacer(),
            widget.verificationkey.used
                ? Text("used", style: Theme.of(context).textTheme.titleSmall)
                : Text(_free, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }

  FutureBuilder buildUserResult() {
    return FutureBuilder(
        future: userFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return dotProgress(context);
          } else {
            UserData user = UserData.fromDocument(snapshot.data);
            UserResult result = UserResult(userData: user, onTap: (){}, onDelete: () {  },);
            return result;
          }
        });
  }
}