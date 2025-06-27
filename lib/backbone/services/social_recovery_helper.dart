import 'dart:convert';
import 'dart:math';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
// import 'package:bitnet/backbone/helper/key_services/bip39_did_generator.dart'; // TODO: Replace with Lightning-native approach
import 'package:bitnet/backbone/helper/size_extension.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/local_storage.dart';
import 'package:bitnet/backbone/services/protocol_controller.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/components/items/userresult.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

Future<bool> initiateSocialSecurity(String mnemonic, String private_key,
    int total_shares, List<UserData> invitedUsers) async {
  //mnemonic, private_key, required_shares, total_shares, user_did
  final logger = Get.find<LoggerService>();
  HttpsCallable callable =
      FirebaseFunctions.instance.httpsCallable('create_keyshares');
  logger.i("Creating Keyshares..");

  try {
    String did = Auth().currentUser!.uid;
    final HttpsCallableResult<dynamic> response =
        await callable.call(<String, dynamic>{
      'user_did': did,
      'mnemonic': mnemonic,
      'private_key': private_key,
      'required_shares': 3,
      'total_shares': total_shares
    });

    final Map<String, dynamic> messageData = response.data;
    List<Map<String, dynamic>> users = [];
    Map shares = response.data['shares'] as Map;
    List<dynamic> keys = shares.keys.toList();
    int? user_index = null;

    for (int i = 0; i < keys.length; i++) {
      if ((shares[keys[i]] as String).isNotEmpty) {
        user_index = i;
        users.add({
          'username': Get.find<ProfileController>().userData.value.username,
          'accepted_invite': true,
          'open_key': '',
          'encrypted_key': keys[i],
        });
      } else {
        try {
          users.add({
            'username': invitedUsers[user_index != null ? i - 1 : i].username,
            'accepted_invite': false,
            'open_key': keys[i],
            'encrypted_key': '',
            //0 for has not been requested, 1 for denied, 2 for accepted
            'request_state': 0,
            'request_invited': false
          });
        } catch (e) {
          Get.find<LoggerService>().i(
              'error while initiating social recovery for users at index: ${i} : ${e}');
        }
      }
    }
    socialRecoveryCollection
        .doc(Get.find<ProfileController>().userData.value.username)
        .set({
      'activated': false,
      'requested_recovery': false,
      'invited_users_amount': total_shares,
      'request_timestamp': null,
      'request_opening': null,
      'request_vetoed': false,
      'prime_mod': messageData['prime_mod'],
      'users': users
    });

    for (int i = 0; i < invitedUsers.length; i++) {
      UserData user = invitedUsers[i];
      ProtocolModel protocol = ProtocolModel(
          protocolId: '',
          protocolType: 'social_recovery_invite_user',
          protocolData: {
            'inviter_doc_id': Get.find<ProfileController>().profileId
          });

      await protocol.sendProtocol(user.docId!);
    }
    return true;
  } catch (e) {
    Get.find<LoggerService>().i('error creating shares: $e');
    return false;
  }
}

Future<String> retrieveMnemonic(
    List<String> shares, int required_shares, String prime_mod) async {
  //mnemonic, private_key, required_shares, total_shares, user_did
  final logger = Get.find<LoggerService>();
  HttpsCallable callable =
      FirebaseFunctions.instance.httpsCallable('retrieve_mnemonic');
  logger.i("Retrieving Mnemonic..");

  try {
    final HttpsCallableResult<dynamic> response = await callable
        .call(<String, dynamic>{
      'shares': shares,
      'required_shares': required_shares,
      'prime_mod': prime_mod
    });

    final Map<String, dynamic> messageData = response.data;

    return messageData['mnemonic'];
  } catch (e) {
    Get.find<LoggerService>().i('error creating shares: $e');
    return '';
  }
}

class AESCipher {
  final String key;
  final int blockSize = 16;

  AESCipher(this.key);

  // Function to encrypt a string
  String encryptText(String plaintext) {
    final keyBytes = _deriveKey(key);
    final iv = _generateIV();
    final aesKey = encrypt.Key(Uint8List.fromList(keyBytes));
    final aesIV = encrypt.IV(Uint8List.fromList(iv));

    final encrypter =
        encrypt.Encrypter(encrypt.AES(aesKey, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(plaintext, iv: aesIV);

    // Return Base64 encoded string
    return base64Encode(iv + encrypted.bytes);
  }

  // Function to decrypt a string
  String decryptText(String ciphertextBase64) {
    final ciphertextBytes = base64Decode(ciphertextBase64);
    final iv = ciphertextBytes.sublist(0, blockSize);
    final ciphertext = ciphertextBytes.sublist(blockSize);

    final keyBytes = _deriveKey(key);
    final aesKey = encrypt.Key(Uint8List.fromList(keyBytes));
    final aesIV = encrypt.IV(iv);

    final encrypter =
        encrypt.Encrypter(encrypt.AES(aesKey, mode: encrypt.AESMode.cbc));
    final decrypted =
        encrypter.decryptBytes(encrypt.Encrypted(ciphertext), iv: aesIV);

    return utf8.decode(decrypted);
  }

  // Derive the key using SHA-256
  List<int> _deriveKey(String key) {
    final keyBytes = utf8.encode(key);
    final sha256Digest = sha256.convert(keyBytes);
    return sha256Digest.bytes;
  }

  // Generate a random IV
  List<int> _generateIV() {
    final random = Random.secure();
    return List<int>.generate(blockSize, (_) => random.nextInt(256));
  }
}

/**
 * after user starts setting up social recovery, send protocol to all users involved
 * protocol_type: social_recovery_invite_user
 * required data:
 * inviter_doc_id
 */
class AcceptSocialInviteWidget extends StatefulWidget {
  const AcceptSocialInviteWidget({super.key, required this.model});
  final ProtocolModel model;

  @override
  State<AcceptSocialInviteWidget> createState() =>
      _AcceptSocialInviteWidgetState();
}

class _AcceptSocialInviteWidgetState extends State<AcceptSocialInviteWidget> {
  UserData? inviterData;
  bool isLoadingButton = false;
  bool isLoadingCancel = false;
  @override
  void initState() {
    super.initState();
    loadInviterData();
  }

  Future<void> loadInviterData() async {
    DocumentSnapshot? doc = await usersCollection
        .doc(widget.model.protocolData['inviter_doc_id'])
        .get();
    inviterData = UserData.fromDocument(doc);
    inviterData = inviterData!.copyWith(docId: doc.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        context: context,
        actions: [
          if (inviterData != null)
            IconButton(
              icon: isLoadingCancel ? dotProgress(context) : Icon(Icons.clear),
              onPressed: () async {
                isLoadingCancel = true;
                setState(() {});
                DocumentSnapshot<Map<String, dynamic>> doc =
                    await socialRecoveryCollection
                        .doc(inviterData!.username)
                        .get();
                List<dynamic> users = doc.data()!['users'];
                int removeIndex = -1;
                for (int i = 0; i < users.length; i++) {
                  if (users[i]['username'] ==
                      Get.find<ProfileController>().userData.value.username) {
                    removeIndex = i;
                  }
                }
                if (removeIndex != -1) {
                  users.removeAt(removeIndex);
                }
                socialRecoveryCollection
                    .doc(inviterData!.username)
                    .update({'users': users});
                isLoadingCancel = false;
                setState(() {});
                context.pop(true);
              },
            )
        ],
        hasBackButton: false,
      ),
      body: inviterData == null
          ? Column(
              children: [
                SizedBox(height: AppTheme.cardPadding * 3),
                dotProgress(context),
                SizedBox(height: 16),
                Text(
                    'Your assistance is needed in certain matters, please hold on...')
              ],
            )
          : Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Avatar(
                            isNft: inviterData!.nft_profile_id.isNotEmpty,
                            mxContent: Uri.parse(inviterData!.profileImageUrl),
                            size: 96),
                        SizedBox(width: 50),
                        Avatar(
                            isNft: Get.find<ProfileController>()
                                .userData
                                .value
                                .nft_profile_id
                                .isNotEmpty,
                            mxContent: Uri.parse(Get.find<ProfileController>()
                                .userData
                                .value
                                .profileImageUrl),
                            size: 96),
                      ],
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                          'Your friend ${inviterData!.username} would like you to join his social recovery.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall),
                    )
                  ],
                ),
                BottomCenterButton(
                  buttonTitle: 'Join',
                  buttonState:
                      isLoadingButton ? ButtonState.loading : ButtonState.idle,
                  onButtonTap: () async {
                    isLoadingButton = true;
                    setState(() {});
                    DocumentSnapshot<Map<String, dynamic>> doc =
                        await socialRecoveryCollection
                            .doc(inviterData!.username)
                            .get();
                    List<dynamic> users = doc.data()!['users'];
                    for (int i = 0; i < users.length; i++) {
                      if (users[i]['username'] ==
                          Get.find<ProfileController>()
                              .userData
                              .value
                              .username) {
                        String openKey = users[i]['open_key'];
                        PrivateData data =
                            await getPrivateData(Auth().currentUser!.uid);
                        AESCipher cipher = AESCipher(data.mnemonic);
                        final logger = Get.find<LoggerService>();

                        logger.i('open key: $openKey');
                        logger.i('mnemonic: ${data.mnemonic}');
                        logger
                            .i('decrypted key: ${cipher.decryptText(openKey)}');
                        logger
                            .i('encrypted key: ${cipher.encryptText(openKey)}');

                        String encryptedText = cipher.encryptText(openKey);
                        logger.i("encrypted text: $encryptedText");
                        users[i]['open_key'] = '';
                        users[i]['encrypted_key'] = encryptedText;
                        users[i]['accepted_invite'] = true;
                      }
                    }
                    bool initiateFinalStep = true;
                    int acceptedUsers = 0;
                    for (int i = 0; i < users.length; i++) {
                      if (users[i]['accepted_invite'] == false) {
                        initiateFinalStep = false;
                      } else {
                        acceptedUsers++;
                      }
                    }
                    if (initiateFinalStep) {
                      Map<String, dynamic> protocolData = {};
                      if (acceptedUsers < 4) {
                        protocolData = {
                          'satisfied_requirements': false,
                        };
                      } else {
                        protocolData = {'satisfied_requirements': true};
                      }
                      ProtocolModel protocol = ProtocolModel(
                          protocolId: '',
                          protocolType: 'social_recovery_set_up',
                          protocolData: protocolData);

                      await protocolCollection
                          .doc(inviterData!.docId!)
                          .set({'initialized': true});
                      await protocolCollection
                          .doc(inviterData!.docId!)
                          .collection('protocols')
                          .add(protocol.toFirestore());
                    }
                    socialRecoveryCollection
                        .doc(inviterData!.username)
                        .update({'users': users});
                    isLoadingButton = false;
                    setState(() {});
                    context.pop(true);
                  },
                )
              ],
            ),
    );
  }
}

/**
 * after the last user accepts, send out protocol
 * no data required, protocol model can be empty
 * protocol_type: social_recovery_set_up
 */
class SettingUpSocialRecoveryWidget extends StatefulWidget {
  const SettingUpSocialRecoveryWidget({super.key, required this.model});
  final ProtocolModel model;
  @override
  State<SettingUpSocialRecoveryWidget> createState() =>
      _SettingUpSocialRecoveryWidgetState();
}

class _SettingUpSocialRecoveryWidgetState
    extends State<SettingUpSocialRecoveryWidget> {
  @override
  void initState() {
    super.initState();
    initAsync();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        appBar: bitnetAppBar(
          context: context,
          hasBackButton: false,
        ),
        body: Column(
          children: [
            SizedBox(height: AppTheme.cardPadding * 3),
            dotProgress(context),
            SizedBox(height: AppTheme.elementSpacing * 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                  widget.model.protocolData['satisfied_requirements']
                      ? 'All invited users have accepted your social recovery invite request, please hold as we finish setting somethings up...'
                      : 'Not enough users accepted your social recovery invite request, resetting social recovery data. please try again...',
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            SizedBox(height: AppTheme.elementSpacing),
            Divider(indent: 32, endIndent: 32),
            SizedBox(height: AppTheme.elementSpacing),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                  'please do not dismiss this sheet, it will dismiss on its own when it is done.'),
            )
          ],
        ),
        context: context);
  }

  void initAsync() async {
    try {
      if (widget.model.protocolData['satisfied_requirements']) {
        DocumentSnapshot<Map<String, dynamic>> doc =
            await socialRecoveryCollection
                .doc(Get.find<ProfileController>().userData.value.username)
                .get();
        PrivateData privData = await getPrivateData(Auth().currentUser!.uid);
        // OLD: Multiple users one node approach - HDWallet-based key derivation for encryption
        // HDWallet hdWallet = HDWallet.fromMnemonic(privData.mnemonic);
        // AESCipher cipher = AESCipher(hdWallet.privkey);

        // NEW: One user one node approach - BIP39-based key derivation for encryption
        // TODO: Replace with Lightning-native key derivation
        String privateKey = "placeholder_private_key"; // Temporary placeholder
        AESCipher cipher = AESCipher(privateKey);
        int userIndex = (doc.data()!['users'] as List).indexOf((test) =>
            test['username'] ==
            Get.find<ProfileController>().userData.value.username);
        for (int i = 0; i < doc.data()!['users'].length; i++) {
          if (doc.data()!['users'][i]['username'] ==
              Get.find<ProfileController>().userData.value.username) {
            userIndex = i;
          }
        }
        String encryptedKey = doc.data()!['users'][userIndex]['encrypted_key'];
        String decryptedKey = cipher.decryptText(encryptedKey);
        List<dynamic> users = doc.data()!['users'];
        users[userIndex]['encrypted_key'] = '';
        users[userIndex]['open_key'] = decryptedKey;
        await socialRecoveryCollection
            .doc(Get.find<ProfileController>().userData.value.username)
            .update({'users': users});

        await Future.delayed(Duration(seconds: 5));
        if (mounted) context.pop(true);
      } else {
        await socialRecoveryCollection
            .doc(Get.find<ProfileController>().userData.value.username)
            .delete();
        Get.find<SettingsController>().initiateSocialRecovery.value = 0;
        Get.find<SettingsController>().pageControllerSocialRecovery =
            PageController(
          initialPage: 0,
        );
        await Future.delayed(Duration(seconds: 5));
        if (mounted) context.pop(true);
      }
    } catch (e) {
      print(e);
      context.pop(false);
    }
  }
}

/**
 * when user attempts to start a social recovery and access his old mnemonic, send protocol to his account,
 * when user receives his mnemonic, delete protocol
 * 
 * protocol_type: social_recovery_access_attempt
 * 
 * no required data
 */
class AccountAccessAttemptWidget extends StatefulWidget {
  const AccountAccessAttemptWidget({super.key, required this.model});
  final ProtocolModel model;

  @override
  State<AccountAccessAttemptWidget> createState() =>
      _AccountAccessAttemptWidgetState();
}

class _AccountAccessAttemptWidgetState
    extends State<AccountAccessAttemptWidget> {
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        context: context,
        appBar: bitnetAppBar(context: context, hasBackButton: false),
        body: Column(children: [
          Container(
            child: Icon(Icons.error_outline, size: 96),
          ),
          SizedBox(height: AppTheme.elementSpacing),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Someone is trying to access your account',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
            child: Text(
                'Someone is trying generate your mnemonic through the social recovery system.',
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
            child: LongButtonWidget(
                customWidth: AppTheme.cardPadding * 13.w,
                customHeight: AppTheme.cardPadding * 2.5,
                onTap: () {
                  socialRecoveryCollection
                      .doc(
                          Get.find<ProfileController>().userData.value.username)
                      .delete();
                  Get.find<SettingsController>().initiateSocialRecovery.value =
                      0;
                  Get.find<SettingsController>().pageControllerSocialRecovery =
                      PageController(
                    initialPage: 0,
                  );
                  context.pop(true);
                },
                title: 'Deny Access'),
          ),
          Divider(indent: 32, endIndent: 32),
          Text(
            'No this is me.',
          ),
          SizedBox(height: 8),
          LongButtonWidget(
              title: 'Allow Access',
              onTap: () {
                context.pop(true);
              },
              customWidth: AppTheme.cardPadding * 6,
              customHeight: AppTheme.cardPadding * 2)
        ]));
  }
}

/**
 * when user wants to recover his account, all users will be sent this protocol.
 * 
 * protocol_type: social_recovery_recovery_request
 * 
 * protocol_data: 
 * inviter_user_doc_id
 * 
 */
class RecoveryRequestWidget extends StatefulWidget {
  const RecoveryRequestWidget({super.key, required this.model});
  final ProtocolModel model;

  @override
  State<RecoveryRequestWidget> createState() => _RecoveryRequestWidgetState();
}

class _RecoveryRequestWidgetState extends State<RecoveryRequestWidget> {
  bool isLoading = true;
  late UserData userData;
  @override
  void initState() {
    super.initState();
    usersCollection
        .doc(widget.model.protocolData['inviter_user_doc_id'])
        .get()
        .then((doc) {
      Map<String, dynamic> data = doc.data()!;
      userData = UserData.fromMap(data);
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      appBar: bitnetAppBar(
        context: context,
        hasBackButton: false,
      ),
      context: context,
      body: Column(
        children: [
          if (isLoading) ...[
            SizedBox(height: AppTheme.cardPadding * 3),
            dotProgress(context),
            SizedBox(height: 16),
            Text(
                'Your assistance is needed in certain matters, please hold on...')
          ],
          if (!isLoading) ...[
            Icon(Icons.key, size: 98),
            SizedBox(height: AppTheme.elementSpacing),
            UserResult(
              userData: userData,
              onTap: () {},
              onDelete: () {},
              model: 2,
            ),
            SizedBox(height: AppTheme.elementSpacing),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                    'Your friend needs to access his account, will you help him?',
                    style: Theme.of(context).textTheme.headlineSmall)),
            SizedBox(height: AppTheme.elementSpacing * 2),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Flexible(
                  child: LongButtonWidget(
                title: 'Ask Again Later',
                customWidth: AppTheme.cardPadding * 6,
                customHeight: AppTheme.cardPadding * 2,
                onTap: () {
                  protocolCollection
                      .doc(Get.find<ProfileController>().profileId)
                      .collection('protocols')
                      .doc(widget.model.protocolId)
                      .update({
                    'activate_time': Timestamp.fromDate(
                        DateTime.now().add(Duration(days: 1)))
                  });
                  context.pop(false);
                },
              )),
              SizedBox(width: 32),
              Flexible(
                  child: LongButtonWidget(
                customWidth: AppTheme.cardPadding * 6,
                customHeight: AppTheme.cardPadding * 2,
                title: 'Allow Access',
                onTap: () async {
                  DocumentSnapshot<Map<String, dynamic>> doc =
                      await socialRecoveryCollection
                          .doc(userData.username)
                          .get();
                  Map<String, dynamic> data = doc.data()!;
                  List<dynamic> users = data['users'];

                  for (int i = 0; i < users.length; i++) {
                    if (users[i]['username'] ==
                        Get.find<ProfileController>().userData.value.username) {
                      String encryptedKey = users[i]['encrypted_key'];
                      PrivateData data =
                          await getPrivateData(Auth().currentUser!.uid);
                      AESCipher cipher = AESCipher(data.mnemonic);
                      String decryptedKey = cipher.decryptText(encryptedKey);
                      users[i]['encrypted_key'] = '';
                      users[i]['open_key'] = decryptedKey;
                      users[i]['request_state'] = 2;
                      await socialRecoveryCollection
                          .doc(userData.username)
                          .update({'users': users});
                      context.pop(true);
                    }
                  }
                },
              ))
            ]),
            SizedBox(height: AppTheme.elementSpacing / 2),
            Divider(
              indent: 32,
              endIndent: 32,
            ),
            SizedBox(height: AppTheme.elementSpacing / 2),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Flexible(flex: 3, child: Text('This is a malicious attempt: ')),
              Flexible(
                  child: LongButtonWidget(
                      title: 'Don\'t allow',
                      onTap: () async {
                        DocumentSnapshot<Map<String, dynamic>> doc =
                            await socialRecoveryCollection
                                .doc(userData.username)
                                .get();
                        Map<String, dynamic> data = doc.data()!;
                        List<dynamic> users = data['users'];

                        for (int i = 0; i < users.length; i++) {
                          if (users[i]['username'] ==
                              Get.find<ProfileController>()
                                  .userData
                                  .value
                                  .username) {
                            users[i]['request_state'] = 1;
                            await socialRecoveryCollection
                                .doc(userData.username)
                                .update({'users': users});
                            context.pop(true);
                          }
                        }
                        context.pop(true);
                      }))
            ])
          ]
        ],
      ),
    );
  }
}

/**
 * when user wants to recover his account, and all previous actions have been done, this presents the mnemonic.
 * 
 * protocol_type: social_recovery_show_mnemonic
 * 
 * protocol_data: 
 * user_doc_id
 * user_name
 * 
 */
class PresentMnemonicWidget extends StatefulWidget {
  const PresentMnemonicWidget({super.key, required this.model});
  final ProtocolModel model;
  @override
  State<PresentMnemonicWidget> createState() => _PresentMnemonicWidgetState();
}

class _PresentMnemonicWidgetState extends State<PresentMnemonicWidget> {
  bool isLoadingMnemonic = true;
  bool failure = false;
  String? mnemonic;
  late TextEditingController textController;
  @override
  void initState() {
    super.initState();
    initAsync();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        context: context,
        appBar: bitnetAppBar(
          context: context,
          hasBackButton: false,
        ),
        body: failure
            ? Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: AppTheme.cardPadding * 3),
                      Icon(
                        Icons.clear,
                        size: AppTheme.cardPadding * 2.75.ws,
                      ),
                      SizedBox(
                        height: AppTheme.cardPadding * 2.h,
                      ),
                      Text(
                        'Failure! it seems that your social recovery request was rejected.',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  BottomCenterButton(
                    buttonState: ButtonState.idle,
                    buttonTitle: 'Confirm',
                    onButtonTap: () {
                      context.pop(true);
                    },
                  )
                ],
              )
            : Stack(
                children: [
                  SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.key,
                          size: AppTheme.cardPadding * 2.ws,
                        ),
                        SizedBox(
                          height: AppTheme.cardPadding / 2.h,
                        ),
                        Text(
                            'Success! Your mnemonic was retrieved successfully.',
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: AppTheme.cardPadding.h,
                        ),
                        Container(
                          width: AppTheme.cardPadding * 12.ws,
                          child: isLoadingMnemonic
                              ? dotProgress(context)
                              : FormTextField(
                                  readOnly:
                                      true, // This makes the text field read-only
                                  isMultiline: true,
                                  controller: textController,
                                  //height: AppTheme.cardPadding * 8,
                                  //width: AppTheme.cardPadding * 10,
                                  hintText: '',
                                ),
                        ),
                        SizedBox(height: AppTheme.elementSpacing / 2),
                        Divider(indent: 32, endIndent: 32),
                        SizedBox(height: AppTheme.elementSpacing / 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Text(
                              'Clicking confirm will purge your social recovery data. please set it up again once you\'ve logged in',
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(height: 204),
                      ],
                    ),
                  ),
                  BottomCenterButton(
                      buttonState: isLoadingMnemonic
                          ? ButtonState.disabled
                          : ButtonState.idle,
                      buttonTitle: 'Confirm',
                      onButtonTap: () {
                        socialRecoveryCollection
                            .doc(widget.model.protocolData['user_name'])
                            .delete();
                        context.pop(true);
                      },
                      onButtonTapDisabled: () {
                        final overlayController = Get.find<OverlayController>();

                        overlayController.showOverlay(
                            'Please wait till your mnemonic is loaded.',
                            color: AppTheme.errorColor);
                      })
                ],
              ));
  }

  void initAsync() async {
    DocumentSnapshot<Map<String, dynamic>> doc = await socialRecoveryCollection
        .doc(widget.model.protocolData['user_name'])
        .get();
    if (!doc.exists) {
      failure = true;
      setState(() {});
      return;
    }
    Map<String, dynamic> data = doc.data()!;
    List<dynamic> users = data['users'];
    List<String> shares = List.empty(growable: true);
    for (int i = 0; i < users.length; i++) {
      if (users[i]['request_state'] == 2 || users[i]['open_key'] != '') {
        shares.add(users[i]['open_key']);
      }
    }
    mnemonic = await retrieveMnemonic(shares, 4, data['prime_mod']);
    textController = TextEditingController(text: mnemonic);
    isLoadingMnemonic = false;

    QuerySnapshot<Map<String, dynamic>> querySnap = await protocolCollection
        .doc(widget.model.protocolData['user_doc_id'])
        .collection('protocols')
        .where('protocol_type', isEqualTo: 'social_recovery_access_attempt')
        .get();
    for (int i = 0; i < querySnap.docs.length; i++) {
      querySnap.docs[i].reference.delete();
    }
    setState(() {});
  }
}

class SocialRecoveryDocModel {
  bool activated;
  int invitedUsersAmount;
  Timestamp? requestOpening;
  Timestamp? requestTimestamp;
  bool requestVetoed;
  bool requestedRecovery;
  List<SocialRecoveryUser> users;
  String primeMod;

  SocialRecoveryDocModel(
      {required this.activated,
      required this.invitedUsersAmount,
      this.requestOpening,
      this.requestTimestamp,
      required this.requestVetoed,
      required this.requestedRecovery,
      required this.users,
      required this.primeMod});

  // Convert Firestore map to SocialRecoveryDocModel
  factory SocialRecoveryDocModel.fromMap(Map<String, dynamic> data) {
    return SocialRecoveryDocModel(
      activated: data['activated'],
      invitedUsersAmount: data['invited_users_amount'],
      requestOpening: data['request_opening'],
      requestTimestamp: data['request_timestamp'],
      requestVetoed: data['request_vetoed'],
      requestedRecovery: data['requested_recovery'],
      primeMod: data['prime_mod'],
      users: (data['users'] as List)
          .map((user) => SocialRecoveryUser.fromMap(user))
          .toList(),
    );
  }

  // Convert Firestore snapshot to SocialRecoveryDocModel
  factory SocialRecoveryDocModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return SocialRecoveryDocModel.fromMap(data);
  }

  // Convert SocialRecoveryDocModel to Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'activated': activated,
      'invited_users_amount': invitedUsersAmount,
      'request_opening': requestOpening,
      'request_timestamp': requestTimestamp,
      'request_vetoed': requestVetoed,
      'requested_recovery': requestedRecovery,
      'prime_mod': primeMod,
      'users': users.map((user) => user.toMap()).toList(),
    };
  }
}

class SocialRecoveryUser {
  bool acceptedInvite;
  String encryptedKey;
  String openKey;
  bool requestInvited;
  int requestState;
  String username;

  SocialRecoveryUser({
    required this.acceptedInvite,
    required this.encryptedKey,
    required this.openKey,
    required this.requestInvited,
    required this.requestState,
    required this.username,
  });

  // Convert map to User
  factory SocialRecoveryUser.fromMap(Map<String, dynamic> data) {
    return SocialRecoveryUser(
      acceptedInvite: data['accepted_invite'],
      encryptedKey: data['encrypted_key'],
      openKey: data['open_key'],
      requestInvited: data['request_invited'] ?? true,
      requestState: data['request_state'] ?? 2,
      username: data['username'],
    );
  }

  // Convert User to map
  Map<String, dynamic> toMap() {
    return {
      'accepted_invite': acceptedInvite,
      'encrypted_key': encryptedKey,
      'open_key': openKey,
      'request_invited': requestInvited,
      'request_state': requestState,
      'username': username,
    };
  }
}
