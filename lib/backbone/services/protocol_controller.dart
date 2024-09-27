import 'dart:collection';
import 'dart:io';

import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/backbone/services/social_recovery_helper.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/protocol_bottom_sheet.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class ProtocolController extends BaseController {
  final bool logIn;
  ProtocolController({required this.logIn});
  late String docId;
  Queue<ProtocolModel> protocolQueue = Queue<ProtocolModel>();
  @override
  void onInit() {
    initAsync();
    super.onInit();
  }

  void initAsync() async {
    if (logIn) {
      docId = Get.find<ProfileController>().profileId;
    } else {
      docId = await getDeviceInfo();
    }
    QuerySnapshot<Map<String, dynamic>> querySnap =
        await protocolCollection.doc(docId).collection('protocols').where('satisfied', isEqualTo: false).get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnap.docs) {
      protocolQueue.add(ProtocolModel.fromFirestore(doc));
    }

    handleProtocols();
  }

  Future<void> updateProtocolStatus(ProtocolModel protocol) async {
    await protocolCollection.doc(docId).collection('protocols').doc(protocol.protocolId).update({'satisfied': true});
  }

  Future<void> handleProtocols() async {
    if (protocolQueue.isNotEmpty) {
      final protocol = protocolQueue.removeFirst();
      // Show bottom sheet with protocol information
      if (protocol.activateTime == null || Timestamp.now().toDate().isAfter(protocol.activateTime!.toDate())) {
        final bool? satisfied = await findProtocolBottomSheet(protocol);

        if (satisfied ?? false) {
          protocol.satisfied = true;
          await updateProtocolStatus(protocol); // Mark protocol as satisfied in Firestore
        }
      }

      // Handle the next protocol in the queue
      handleProtocols();
    }
  }

  Future<bool?> findProtocolBottomSheet(ProtocolModel protocol) async {
    switch (protocol.protocolType) {
      case 'social_recovery_invite_user':
        return showProtocolBottomSheet(
            child: AcceptSocialInviteWidget(
          model: protocol,
        ));
      case 'social_recovery_set_up':
        return showProtocolBottomSheet(isDismissible: false, child: SettingUpSocialRecoveryWidget(model: protocol));
      case 'social_recovery_access_attempt':
        return showProtocolBottomSheet(isDismissible: false, child: AccountAccessAttemptWidget(model: protocol));
      case 'social_recovery_recovery_request':
        return showProtocolBottomSheet(child: RecoveryRequestWidget(model: protocol));
      case 'social_recovery_show_mnemonic':
        return showProtocolBottomSheet(
            isDismissible: false,
            child: PresentMnemonicWidget(
              model: protocol,
            ));
      default:
        return true;
    }
  }
}

class ProtocolModel {
  final String protocolId;
  final String protocolType;
  final Timestamp? activateTime;
  final Map<String, dynamic> protocolData;
  bool satisfied;

  ProtocolModel({
    this.activateTime,
    required this.protocolId,
    required this.protocolType,
    required this.protocolData,
    this.satisfied = false,
  });

  factory ProtocolModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    return ProtocolModel(
      protocolId: doc.id,
      activateTime: doc.data()!.containsKey('activate_time') ? doc.data()!['activate_time'] : null,
      protocolType: doc.data()!['protocol_type'],
      protocolData: doc.data()!['protocol_data'],
      satisfied: doc.data()!['satisfied'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'protocol_type': protocolType,
      'protocol_data': protocolData,
      'activate_time': activateTime,
      'satisfied': satisfied,
    };
  }

  Future<void> sendProtocol(String userDocId) async {
    await protocolCollection.doc(userDocId).set({'initialized': true});
    await protocolCollection.doc(userDocId).collection('protocols').add(this.toFirestore());
  }
}

Future<String> getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor!;
  } else {
    throw UnimplementedError('I dont see the use case for this yet.');
  }
}
