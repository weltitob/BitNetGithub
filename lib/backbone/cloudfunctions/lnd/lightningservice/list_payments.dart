import 'dart:io';
import 'package:bitnet/backbone/cloudfunctions/aws/litd_controller.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/helper/http_no_ssl.dart';
import 'package:bitnet/backbone/helper/loadmacaroon.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/dio/dio_service.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// Future<RestResponse> listPayments() async {
//   LoggerService logger = Get.find();
//
//   final litdController = Get.find<LitdController>();
//   final String restHost = litdController.litd_baseurl.value;
//
//   // const String macaroonPath = 'assets/keys/lnd_admin.macaroon'; // Update the path to the macaroon file
//   String url = 'https://$restHost/v1/payments';
//
//   ByteData byteData = await loadAdminMacaroonAsset();
//   List<int> bytes = byteData.buffer.asUint8List();
//   String macaroon = bytesToHex(bytes);
//
//   logger.i("Macaroon: $macaroon used in litstPayments()");
//
//   Map<String, String> headers = {
//     'Grpc-Metadata-macaroon': macaroon,
//   };
//
//   HttpOverrides.global = MyHttpOverrides();
//
//   //data still needs to add the include_incomplete parameter
//
//   try {
//       final DioClient dioClient = Get.find<DioClient>();
//     var response = await dioClient.get(url:url, headers: headers,);
//     // Print raw response for debugging
//     logger.d('Raw Response Payments: ${response.data}');
//
//     if (response.statusCode == 200) {
//       print(response.data);
//       return RestResponse(statusCode: "${response.statusCode}", message: "Successfully retrieved Lightning Payments", data: response.data);
//
//     } else {
//       print('Failed to load data: ${response.statusCode}, ${response.data}');
//       return RestResponse(statusCode: "error", message: "Failed to load data: ${response.statusCode}, ${response.data}", data: {});
//     }
//   } catch (e) {
//     print('Error: $e');
//     return RestResponse(statusCode: "error", message: "Failed to load data: Could not get response from Lightning node!", data: {});
//   }
// }

Future<List<LightningPayment>> listPayments(String acc) async {
  final logger = Get.find<LoggerService>();
  logger.i("Calling listPayments() with account $acc");
  QuerySnapshot<Map<String, dynamic>> query =
  await backendRef.doc(acc).collection('payments').get();
  List<LightningPayment> payments =
  query.docs.map((map) => LightningPayment.fromJson(map.data())).toList();
  return payments;
}

Future<List<InternalRebalance>> listInternalRebalances(String userPubKey) async {
  final logger = Get.find<LoggerService>();
  logger.i("Fetching internal rebalances for account: $userPubKey");

  try {
    QuerySnapshot<Map<String, dynamic>> query = await backendRef
        .doc(userPubKey)
        .collection('internalRebalances')
        .orderBy('timestamp', descending: true)  // Optional: sort by timestamp
        .get();

    List<InternalRebalance> rebalances = query.docs
        .map((doc) => InternalRebalance.fromFirestore(doc))
        .toList();

    logger.i("Found ${rebalances.length} internal rebalances");
    return rebalances;
  } catch (e) {
    logger.e("Error fetching internal rebalances: $e");
    throw Exception("Failed to fetch internal rebalances: $e");
  }
}

class InternalRebalance {
  final String senderUserUid;
  final String receiverUserUid;
  final String internalAccountIdReceiver;
  final String internalAccountIdSender;
  final int amountSatoshi;
  final String lightningAddressResolved;
  final int timestamp; // Jetzt als int behandeln
  final String paymentNetwork;
  final String rebalanceServer;
  final Map<String, dynamic> senderResponseRebalanceServer;
  final Map<String, dynamic> receiverResponseRebalanceServer;

  InternalRebalance({
    required this.senderUserUid,
    required this.receiverUserUid,
    required this.internalAccountIdReceiver,
    required this.internalAccountIdSender,
    required this.amountSatoshi,
    required this.lightningAddressResolved,
    required this.timestamp,
    required this.paymentNetwork,
    required this.rebalanceServer,
    required this.senderResponseRebalanceServer,
    required this.receiverResponseRebalanceServer,
  });

  // Erstellen aus Firestore-Dokument
  factory InternalRebalance.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return InternalRebalance.fromJson(data);
  }

  // Erstellen aus JSON
  factory InternalRebalance.fromJson(Map<String, dynamic> json) {
    return InternalRebalance(
      senderUserUid: json['SenderuserUid'] ?? '',
      receiverUserUid: json['ReceiveruserUid'] ?? '',
      internalAccountIdReceiver: json['internalAccountId_receiver'] ?? '',
      internalAccountIdSender: json['internalAccountId_sender'] ?? '',
      amountSatoshi: json['amountSatoshi'] ?? 0,
      lightningAddressResolved: json['lightningAddress_resolved'] ?? '',
      // Umwandlung von Timestamp zu int (Sekunden seit Epoche)
      timestamp: (json['timestamp'] as Timestamp).seconds,
      paymentNetwork: json['paymentnetwork'] ?? '',
      rebalanceServer: json['rebalanceServer'] ?? '',
      senderResponseRebalanceServer: json['sender_response_rebalance_server'] ?? {},
      receiverResponseRebalanceServer: json['receiver_response_rebalance_server'] ?? {},
    );
  }

  // Konvertierung in JSON
  Map<String, dynamic> toJson() {
    return {
      'SenderuserUid': senderUserUid,
      'ReceiveruserUid': receiverUserUid,
      'internalAccountId_receiver': internalAccountIdReceiver,
      'internalAccountId_sender': internalAccountIdSender,
      'amountSatoshi': amountSatoshi,
      'lightningAddress_resolved': lightningAddressResolved,
      // Hier setzen wir den timestamp als int-Wert.
      'timestamp': timestamp,
      'paymentnetwork': paymentNetwork,
      'rebalanceServer': rebalanceServer,
      'sender_response_rebalance_server': senderResponseRebalanceServer,
      'receiver_response_rebalance_server': receiverResponseRebalanceServer,
    };
  }

  // Copy-with-Methode für Immutabilität
  InternalRebalance copyWith({
    String? senderUserUid,
    String? receiverUserUid,
    String? internalAccountIdReceiver,
    String? internalAccountIdSender,
    int? amountSatoshi,
    String? lightningAddressResolved,
    int? timestamp,
    String? paymentNetwork,
    String? rebalanceServer,
    Map<String, dynamic>? senderResponseRebalanceServer,
    Map<String, dynamic>? receiverResponseRebalanceServer,
  }) {
    return InternalRebalance(
      senderUserUid: senderUserUid ?? this.senderUserUid,
      receiverUserUid: receiverUserUid ?? this.receiverUserUid,
      internalAccountIdReceiver: internalAccountIdReceiver ?? this.internalAccountIdReceiver,
      internalAccountIdSender: internalAccountIdSender ?? this.internalAccountIdSender,
      amountSatoshi: amountSatoshi ?? this.amountSatoshi,
      lightningAddressResolved: lightningAddressResolved ?? this.lightningAddressResolved,
      timestamp: timestamp ?? this.timestamp,
      paymentNetwork: paymentNetwork ?? this.paymentNetwork,
      rebalanceServer: rebalanceServer ?? this.rebalanceServer,
      senderResponseRebalanceServer: senderResponseRebalanceServer ?? this.senderResponseRebalanceServer,
      receiverResponseRebalanceServer: receiverResponseRebalanceServer ?? this.receiverResponseRebalanceServer,
    );
  }
}

// Added InternalRebalancesList class
class InternalRebalancesList {
  final List<InternalRebalance> rebalances;

  InternalRebalancesList({
    required this.rebalances,
  });

  factory InternalRebalancesList.fromJson(Map<String, dynamic> json) {
    return InternalRebalancesList(
      rebalances: json['rebalances'] != null
          ? List<InternalRebalance>.from(
          json['rebalances'].map((x) => InternalRebalance.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rebalances': rebalances.map((x) => x.toJson()).toList(),
    };
  }
}
