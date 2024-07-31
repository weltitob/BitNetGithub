import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_invoices.dart';
import 'package:bitnet/backbone/cloudfunctions/lnd/lightningservice/list_payments.dart';
import 'package:bitnet/backbone/helper/databaserefs.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/firebase/restresponse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LightningInfoController extends GetxController {
  RxBool loadingState = false.obs;

  List<ReceivedInvoice> lightningInvoices = [];
  List<LightningPayment> lightningPayments = [];
  List<dynamic> combinedTransactions = [];

  Future<bool> getLightningInvoices() async {
    LoggerService logger = Get.find();
    logger.i("Getting lightning invoices");
    try {
      RestResponse restLightningInvoices = await listInvoices();
      ReceivedInvoicesList lightningInvoices =
          ReceivedInvoicesList.fromJson(restLightningInvoices.data);
      List<ReceivedInvoice> settledInvoices = lightningInvoices.invoices
          .where((invoice) => invoice.settled)
          .toList();
      this.lightningInvoices = settledInvoices;
      List<Map<String, dynamic>> mapList = List<Map<String, dynamic>>.from(
          restLightningInvoices.data['invoices'] as List);
      sendPaymentDataReceivedInvoiceBatch(mapList);
    } on Error catch (_) {
      return false;
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<void> sendPaymentDataReceivedInvoiceBatch(
      List<Map<String, dynamic>> data) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await btcReceiveRef
        .doc(Auth().currentUser!.uid)
        .collection('lnbc')
        .get();
    List<Map<String, dynamic>> allData =
        snapshot.docs.map((doc) => doc.data()).toList();
    ReceivedInvoicesList btcFinalList = ReceivedInvoicesList.fromList(allData);
    List<ReceivedInvoice> transactions = btcFinalList.invoices;
    List<ReceivedInvoice> newTransactions =
        ReceivedInvoicesList.fromList(data).invoices;
    List<String> duplicateHashes = List.empty(growable: true);
    for (int i = 0; i < newTransactions.length; i++) {
      ReceivedInvoice item1 = newTransactions[i];
      for (int j = 0; j < transactions.length; j++) {
        ReceivedInvoice item2 = transactions[j];
        if ((item1.rHash == item2.rHash)) {
          duplicateHashes.add(item1.rHash);
        }
      }
    }
    newTransactions.removeWhere((test) => duplicateHashes.contains(test.rHash));
    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (int i = 0; i < newTransactions.length; i++) {
      batch.set(
          btcReceiveRef.doc(Auth().currentUser!.uid).collection('lnbc').doc(),
          newTransactions[i].toJson());
    }
    batch.commit();
  }

  Future<bool> getLightningPayments() async {
    LoggerService logger = Get.find();
    try {
      logger.i("Getting lightning payments");
      RestResponse restLightningPayments = await listPayments();
      LightningPaymentsList lightningPayments =
          LightningPaymentsList.fromJson(restLightningPayments.data);
      this.lightningPayments = lightningPayments.payments;
    } on Error catch (_) {
      return false;
    } catch (e) {
      return false;
    }
    return true;
  }

  void combineTransactions() {
    combinedTransactions = [];
    combinedTransactions.addAll(lightningInvoices);
    combinedTransactions.addAll(lightningPayments);
    // combinedTransactions.sort((a, b) {
    //   DateTime dateA = a is ReceivedInvoice ? a.settleDate : a.creationDate;
    //   DateTime dateB = b is ReceivedInvoice ? b.settleDate : b.creationDate;
    //   return dateB.compareTo(dateA);
    // });
  }

  @override
  void onInit() {
    super.onInit();
    loadingState.value = true;
    getLightningInvoices().then((value) {
      getLightningPayments().then((value) {
        combineTransactions();
        loadingState.value = false;
      });
    });
  }
}
