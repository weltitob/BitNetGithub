import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/firebase/verificationcode.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bitnet/intl/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.inviteContact,
        context: context,
        buttonType: ButtonType.transparent,
        onTap: () {
          final controller = Get.find<SettingsController>();
          controller.switchTab('main');
        },
      ),
      body: Container(
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
                height: 400,
                child: Center(child: dotProgress(context)),
              );
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppTheme.cardPadding * 3),
                  Padding(
                    padding: const EdgeInsets.all(AppTheme.cardPadding),
                    child: Text(
                      L10n.of(context)!.inviteDescription,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: Text(
                      "Invitation Keys",
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final verificationkey = snapshot.data![index];
                      return _KeyItem(verificationkey: verificationkey);
                    },
                  ),
                ],
              ),
            );
          },
        ),
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
  void initState() {
    super.initState();
    getUser(widget.verificationkey.receiver);
  }

  getUser(String userId) {
    Future<QuerySnapshot> user =
        usersCollection.where("did", isEqualTo: userId).get();
    setState(() {
      userFuture = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.verificationkey.used
          ? () {
              context.goNamed(
                "/profile",
                pathParameters: {'profileId': widget.verificationkey.receiver},
              );
            }
          : () {
              // copy the key
              _free = "copied";
              Clipboard.setData(
                ClipboardData(text: widget.verificationkey.code),
              );
              setState(() {});
            },
      child: Container(
        height: AppTheme.cardPadding * 2.h,
        margin: const EdgeInsets.symmetric(
          horizontal: AppTheme.cardPadding * 1.5,
        ).copyWith(
          bottom: AppTheme.cardPadding,
        ),
        child: GlassContainer(
          borderRadius: AppTheme.cardRadiusSmall,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding,
            ),
            child: Row(
              children: <Widget>[
                // If used, show user result. Otherwise, show an icon.
                widget.verificationkey.used
                    ? Flexible(child: buildUserResult())
                    : Icon(
                        Icons.key,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        size: AppTheme.iconSize,
                      ),
                const SizedBox(width: AppTheme.cardPadding),
                // Key code
                Flexible(
                  child: Text(
                    widget.verificationkey.code,
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis, // Prevent overflow
                  ),
                ),
                const Spacer(),
                // If used, show "used". Otherwise, show _free/copy status
                Text(
                  widget.verificationkey.used ? "used" : _free,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<QuerySnapshot> buildUserResult() {
    return FutureBuilder<QuerySnapshot>(
      future: userFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return dotProgress(context);
        } else if (snapshot.data!.docs.isEmpty) {
          return Text("No user found");
        } else {
          // Grab the first matching document
          final docSnapshot = snapshot.data!.docs.first;
          // Convert DocumentSnapshot to UserData
          UserData user = UserData.fromDocument(docSnapshot);
          return Avatar(
            size: AppTheme.cardPadding * 1.5.h,
            mxContent: Uri.parse(user.profileImageUrl),
            type: profilePictureType.lightning,
            isNft: user.nft_profile_id.isNotEmpty,
            onTap: () async {
              //forward to the users profile
              context.goNamed(
                "/profile",
                pathParameters: {'profileId': user.did},
              );
            },
          );
        }
      },
    );
  }
}
