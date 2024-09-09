//transaction controller

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:bitnet/backbone/cloudfunctions/check_addresses_ownership.dart';
import 'package:bitnet/backbone/mempool_utils.dart';
import 'package:bitnet/backbone/services/base_controller/base_controller.dart';
import 'package:bitnet/models/mempool_models/address_component.dart';
import 'package:bitnet/models/mempool_models/transactionCacheModel.dart' as cacheTx;
import 'package:bitnet/models/mempool_models/transactionRbfModel.dart';
import 'package:bitnet/models/mempool_models/txConfirmDetail.dart';
import 'package:bitnet/models/mempool_models/txModel.dart' as txModel;
import 'package:bitnet/models/mempool_models/validate_address_component.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/model/transaction_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class TransactionController extends BaseController {
  TransactionController({this.txID});
  final HomeController homeController = Get.put(HomeController());
  TransactionModel? transactionModel;
  RxList<TransactionModel> subTransactionModel = <TransactionModel>[].obs;
  AddressComponentModel? addressComponentModel;
  ValidateAddressComponentModel? validateAddressComponentModel;
  cacheTx.TransactionCacheModel? transactionCacheModel;
  TransactionRbfModel? transactionRbfModel;
  String addressId = '';
  String amount = '';
  RxBool isLoading = false.obs;
  RxBool isLoadingOutSpends = false.obs;
  RxBool isLoadingAddress = false.obs;
  RxInt selectedCardIndex = 0.obs;

  var dataOutSpents;
  var dataOutSpents1;
  String baseUrl = 'https://mempool.space/api/';
  String? txID = '';
  String feeUsd = '', feeSat = '';
  RxDouble feeRate = 0.0.obs;
  RxBool showDetail = false.obs;
  RxBool confirmationStatus = false.obs;
  RxBool isRbfTransaction = false.obs;
  RxBool isTaproot = false.obs;

  RxBool segwitEnabled = false.obs;
  RxBool segwitCrossed = false.obs;
  RxBool segwitisGreen = false.obs;
  RxBool rbfEnabled = false.obs;
  RxBool rbfCrossed = false.obs;
  RxBool rbfisGreen = false.obs;
  RxBool taprootEnabled = false.obs;
  RxBool taprootCrossed = false.obs;
  RxBool taprootisGreen = false.obs;
  RxBool getHexValue = false.obs;
  bool hideUnconfirmed = false;
  bool replaced = false;
  bool removed = false;
  int? height;
  int? chainTip;
  RxInt confirmations = 0.obs;
  RxInt feeRating = 0.obs;
  int? medianFeeNeeded;
  int? overpaidTimes;
  RxString statusTransaction = 'Confirmed'.obs;
  RxString hexValue = ''.obs;
  RxString replacedTx = ''.obs;
  List<String> ids = [];
  RxInt page = 1.obs;
  String searchValue = '';
  List<String> currentOwnedAddresses = [];

  void toggleExpansion() {
    showDetail.value = !showDetail.value;
  }

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
  }

  RxBool isShowBTC = true.obs;
  RxDouble input = 0.0.obs;
  RxDouble output = 0.0.obs;
  RxDouble usdValue = 0.0.obs;
  RxDouble inputBTC = 0.0.obs;
  RxDouble outputBTC = 0.0.obs;
  RxDouble inputDollar = 0.0.obs;
  RxDouble outputDollar = 0.0.obs;

  btcToDoller() {
    outPutDollars();
  }

  changePage(int pageNo) {
    page.value = pageNo;
  }

  String formatTimeAgo(DateTime dateTime) {
    return timeago.format(dateTime);
  }

  calculateConfirmation() async {
    if (chainTip != null && height != null) {
      confirmations.value = math.max(1, chainTip! - height! + 1);
      print(confirmationStatus.value);
    } else {
      confirmations.value = 0;
    }
  }

  calculateStatus(bool status) async {
    if (status && height != null) {
      statusTransaction.value = "Confirmed";
    }
    if (!status && !hideUnconfirmed && homeController.isRbfTransaction.value) {
      statusTransaction.value = "Replaced";
    }
    if (!status && !hideUnconfirmed && !homeController.isRbfTransaction.value && removed) {
      statusTransaction.value = "Removed";
    }
    if (!status && chainTip != null && !hideUnconfirmed && !homeController.isRbfTransaction.value && !removed) {
      statusTransaction.value = "Unconfirmed";
    }
  }

  String outPutBTC(int index) {
    double value = (transactionModel!.vout![index].value!) / 100000000;
    outputBTC.value = double.parse(value.toStringAsFixed(8));
    return outputBTC.value.toString();
  }

  String inPutBTC(int index) {
    double value = (transactionModel!.vin![index].prevout!.value!) / 100000000;
    inputBTC.value = double.parse(value.toStringAsFixed(8));

    return inputBTC.value.toString();
  }

  String outPutDollar(int index) {
    double value1 = (transactionModel!.vout![index].value!) / 100000000;
    // outputBTC.value = double.parse(value1.toStringAsFixed(8));
    double value = ((value1 * 100000000) * currentUSD.value) / 100000000;
    outputDollar.value = double.parse(value.toStringAsFixed(2));
    return outputDollar.value.toStringAsFixed(2);
  }

  // var formatAmount = NumberFormat('#,##,000');

  // String formatAmount(String price) {
  //   String priceInText = "";
  //   int counter = 0;
  //   for (int i = (price.length - 1); i >= 0; i--) {
  //     counter++;
  //     String str = price[i];
  //     if ((counter % 3) != 0 && i != 0) {
  //       priceInText = "$str$priceInText";
  //     } else if (i == 0) {
  //       priceInText = "$str$priceInText";
  //     } else {
  //       priceInText = ",$str$priceInText";
  //     }
  //   }
  //   return priceInText.trim();
  // }

  String inPutDollar(int index) {
    double value = (((transactionModel!.vin![index].prevout!.value!) / 100000000 * 100000000) * currentUSD.value) / 100000000;
    inputDollar.value = double.parse(value.toStringAsFixed(2));
    return formatPrice(inputDollar.value.toStringAsFixed(0));
  }

  Color inputIconColor() {
    double inpt = input.value;
    double outpt = output.value;

    if (inpt > outpt) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  Color outputIconColor() {
    double inpt = input.value;
    double outpt = output.value;

    if (inpt < outpt) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  var timeST = ''.obs;
  RxString requestTime = ''.obs;
  RxString localTime = ''.obs;
  RxDouble effectiveFeeRate = 0.0.obs;

  RxInt currentUSD = 0.obs;

  String formatPrice(String price) {
    print(price);
    final format = NumberFormat.decimalPattern('hi');
    return format.format(int.parse(price));
  }

  int txTime = 0;

  void startUpdatingTimestamp() async {
    int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    // timeST.value = formatTimestamp(
    //     transactionModel!.status!.blockTime?.toInt() ?? currentTime);
    final firstseen = await getTimeStamp(txID!);
    txTime = firstseen!;
    localTime.value = formatLocalTime(transactionModel!.status!.blockTime?.toInt() ?? currentTime);
    // timerTime = Timer.periodic(const Duration(seconds: 1), (timer) async {
    // print(txTime);
    confirmationStatus.value = transactionModel!.status!.confirmed!;
    // print('${confirmationStatus.value}' + 'status');
    timeST.value = formatTimestamp(firstseen ?? currentTime);
    // });
  }

  Future<int?> getTimeStamp(String txID) async {
    try {
      var local;
      String url = 'https://mempool.space/api/v1/transaction-times?txId[]=$txID';
      // print(url);
      await dioClient.get(url: url).then((value) {
        local = value;
      });
      isLoading.value = false;
      return local.data.first;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    return null;
  }

  getSingleTransactionRbf(String txID) async {
    print('get rbf called');
    try {
      // isLoading.value = true;
      // Timer.periodic(Duration(seconds: 5), (timer) async {
      //
      String url = '${baseUrl}tx/$txID/rbf';
      print(url);
      await dioClient.get(url: url).then((value) async {
        print(value.data);
        transactionRbfModel = TransactionRbfModel.fromJson(value.data);
        final homeController = Get.find<HomeController>();
        chainTip = homeController.bitcoinData.first.height;
        await calculateConfirmation();
        await calculateStatus(transactionCacheModel!.status.confirmed);
      });
      isLoading.value = false;
      // });
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  getSingleTransactionCache(String txID) async {
    print('get cached called');
    try {
      // isLoading.value = true;
      // Timer.periodic(Duration(seconds: 5), (timer) async {
      //
      String url = '${baseUrl}tx/$txID/cached';
      print(url);
      await dioClient.get(url: url).then((value) async {
        print(value.data);
        transactionCacheModel = cacheTx.TransactionCacheModel.fromJson(value.data);
        final homeController = Get.find<HomeController>();
        chainTip = homeController.bitcoinData.first.height;
        // print(height);
        // print(chainTip);
        await calculateConfirmation();
        await calculateStatus(transactionCacheModel!.status.confirmed);
      });

      isLoading.value = false;
      // });
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  // Timer? timer;
  // Timer? timerLatest;
  // Timer? timerTime;
  txModel.TxPosition? txPosition;
  String? balance;

  changeSocket() {
    channel.sink.add('{"track-rbf-summary":false}');
    channel.sink.add('{"action":"want","data":["blocks","mempool-blocks"]}');
    channel.sink.add('{"track-tx":"${txID!}"}');
  }

  getTrans(String txID) async {
    // timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
    String url = '${baseUrl}tx/$txID';
    await dioClient.get(url: url).then((value) async {
      transactionModel = TransactionModel.fromJson(value.data);
      height = transactionModel!.status!.blockHeight;
      final homeController = Get.find<HomeController>();
      chainTip = homeController.bitcoinData.first.height;
      homeController.txConfirmed.value = transactionModel!.status!.confirmed!;
      // replaced = true;
      await calculateConfirmation();
      await calculateStatus(transactionModel!.status!.confirmed!);
    });
    // });
  }

  getCpfp(String txID) async {
    String url = '${baseUrl}v1/cpfp/$txID';
    await dioClient.get(url: url).then((value) async {
      effectiveFeeRate.value = value.data["effectiveFeePerVsize"] ?? 0.0;
    });
  }

  getAddressComponent(String? addressId) async {
    this.addressId = addressId ?? '';
    isLoadingAddress.value = true;
    try {
      String url = '${baseUrl}v1/validate-address/$addressId';
      print(url);
      await dioClient.get(url: url).then((value) async {
        print(value.data);
        validateAddressComponentModel = ValidateAddressComponentModel.fromJson(value.data);
        print(validateAddressComponentModel?.isvalid);
        validateAddressComponentModel!.isvalid
            ? await dioClient.get(url: '${baseUrl}/address/$addressId').then((value) async {
                print(value.data);
                addressComponentModel = AddressComponentModel.fromJson(value.data);

                await getSubTransaction();
              })
            : null;
        isLoadingAddress.value = false;
      });
    } catch (e, tr) {
      print(e);
      print(tr);
      isLoadingAddress.value = false;
    }
  }

  getTransLatest(String txID) async {
    try {
      isLoading.value = true;
      // timerLatest = Timer.periodic(Duration(seconds: 5), (timer) async {
      String url = '${baseUrl}tx/$txID';

      try {
        await dioClient.get(url: url).then((value) async {
          transactionModel = TransactionModel.fromJson(value.data);
          height = transactionModel!.status!.blockHeight;
          final homeController = Get.find<HomeController>();
          chainTip = homeController.bitcoinData.first.height;
          // print(height);
          // print(chainTip);
          await calculateConfirmation();
          await calculateStatus(transactionModel!.status!.confirmed!);
          isLoading.value = false;
        });
      } catch (e) {
        isLoading.value = false;

        // timerLatest!.cancel();
        Get.snackbar('Transaction Not Found', '');
      }
      // });
    } catch (e) {
      isLoading.value = false;
    }
  }

  var P2SH_P2WPKH_COST = 21 * 4; // the WU cost for the non-witness part of P2SH-P2WPKH
  var P2SH_P2WSH_COST = 35 * 4; // the WU cost for the non-witness part of P2SH-P2WSH

  Map<String, int>? parseMultisigScript(String script) {
    if (script.isEmpty) {
      return null;
    }

    List<String> ops = script.split(' ');

    if (ops.length < 3 || ops.removeLast() != 'OP_CHECKMULTISIG') {
      return null;
    }

    String? opN = ops.removeLast();

    if (!opN.startsWith('OP_PUSHNUM_')) {
      return null;
    }

    int n = int.tryParse(RegExp(r'\d+').firstMatch(opN)!.group(0)!) ?? 0;

    if (ops.length < n * 2 + 1) {
      return null;
    }

    // pop n public keys
    for (int i = 0; i < n; i++) {
      String? publicKey = ops.removeLast();

      if (!RegExp(r'^0((2|3)\w{64}|4\w{128})$').hasMatch(publicKey)) {
        return null;
      }

      String? opPushBytes = ops.removeLast();

      if (!RegExp(r'^OP_PUSHBYTES_(33|65)$').hasMatch(opPushBytes)) {
        return null;
      }
    }

    String? opM = ops.removeLast();

    if (!opM.startsWith('OP_PUSHNUM_')) {
      return null;
    }

    int m = int.tryParse(RegExp(r'\d+').firstMatch(opM)!.group(0)!) ?? 0;

    if (ops.isNotEmpty) {
      return null;
    }

    return {'m': m, 'n': n};
  }

  Map<String, double> segwitGains = {
    "realizedSegwitGains": 0,
    "potentialSegwitGains": 0,
    "potentialP2shSegwitGains": 0,
    "potentialTaprootGains": 0,
    "realizedTaprootGains": 0
  };

  double witnessSize(Vin vin) {
    return vin.witness != null ? vin.witness!.fold<double>(0, (S, w) => S + (w.length / 2)) : 0;
  }

  double scriptSigSize(Vin vin) {
    return vin.scriptsig != null ? vin.scriptsig!.length / 2 : 0;
  }

  double realizedSegwitGains = 0;
  double potentialSegwitGains = 0;
  double potentialP2shSegwitGains = 0;
  double potentialTaprootGains = 0;
  double realizedTaprootGains = 0;

  Map<String, double> calcSegwitFeeGains(TransactionModel tx) {
    // calculated in weight units
    realizedSegwitGains = 0;
    potentialSegwitGains = 0;
    potentialP2shSegwitGains = 0;
    potentialTaprootGains = 0;
    realizedTaprootGains = 0;

    for (var vin in tx.vin!) {
      if (vin.prevout == null) {
        continue;
      }

      bool isP2pk = vin.prevout!.scriptpubkeyType == 'p2pk';
      final isBareMultisig = parseMultisigScript(vin.prevout!.scriptpubkeyAsm!) != null;
      final isP2pkh = vin.prevout!.scriptpubkeyType == 'p2pkh';
      final isP2sh = vin.prevout!.scriptpubkeyType == 'p2sh';
      final isP2wsh = vin.prevout!.scriptpubkeyType == 'v0_p2wsh';
      final isP2wpkh = vin.prevout!.scriptpubkeyType == 'v0_p2wpkh';
      final isP2tr = vin.prevout!.scriptpubkeyType == 'v1_p2tr';

      final op = vin.scriptsig != null ? vin.scriptsigAsm!.split(' ')[0] : null;
      final isP2shP2Wpkh = isP2sh && vin.witness != null && op == 'OP_PUSHBYTES_22';
      final isP2shP2Wsh = isP2sh && vin.witness != null && op == 'OP_PUSHBYTES_34';

      if (isP2tr) {
        realizedSegwitGains += (witnessSize(vin) + (isP2tr ? 42 : 0)) * 3;
      } else if (isP2shP2Wpkh) {
        realizedSegwitGains += witnessSize(vin) * 3 - P2SH_P2WPKH_COST;
        potentialSegwitGains += P2SH_P2WPKH_COST;
      } else if (isP2shP2Wsh) {
        realizedSegwitGains += witnessSize(vin) * 3 - P2SH_P2WSH_COST;
        potentialSegwitGains += P2SH_P2WSH_COST;
      } else if (isBareMultisig) {
        var fullGains = scriptSigSize(vin) * 3;
        if (isBareMultisig) {
          // a _bare_ multisig has the keys in the output script, but P2SH and P2WSH require them to be in the scriptSig/scriptWitness
          fullGains -= vin.prevout!.scriptpubkey!.length / 2;
        }
        potentialSegwitGains += fullGains;
        potentialP2shSegwitGains += fullGains - (isP2pkh ? P2SH_P2WPKH_COST : P2SH_P2WSH_COST);
      }
      // switch (true) {
      //   // Native Segwit - P2WPKH/P2WSH/P2TR
      //   case isP2wpkh:
      //   case isP2wsh:
      //   case isP2tr:
      //     realizedSegwitGains += (witnessSize(vin) + (isP2tr ? 42 : 0)) * 3;
      //     // XXX P2WSH output creation is more expensive, should we take this into consideration?
      //     break;

      //   // Backward compatible Segwit - P2SH-P2WPKH
      //   case isP2shP2Wpkh:
      //     // the scriptSig is moved to the witness, but we have extra 21 extra non-witness bytes (84 WU)
      //     realizedSegwitGains += witnessSize(vin) * 3 - P2SH_P2WPKH_COST;
      //     potentialSegwitGains += P2SH_P2WPKH_COST;
      //     break;

      //   // Backward compatible Segwit - P2SH-P2WSH
      //   case isP2shP2Wsh:
      //     // the scriptSig is moved to the witness, but we have extra 35 extra non-witness bytes (140 WU)
      //     realizedSegwitGains += witnessSize(vin) * 3 - P2SH_P2WSH_COST;
      //     potentialSegwitGains += P2SH_P2WSH_COST;
      //     break;

      //   // Non-segwit P2PKH/P2SH/P2PK/bare multisig
      //   case isP2pkh:
      //   case isP2sh:
      //   case isP2pk:
      //   case isBareMultisig:
      //     {
      //       var fullGains = scriptSigSize(vin) * 3;
      //       if (isBareMultisig) {
      //         // a _bare_ multisig has the keys in the output script, but P2SH and P2WSH require them to be in the scriptSig/scriptWitness
      //         fullGains -= vin.prevout!.scriptpubkey!.length / 2;
      //       }
      //       potentialSegwitGains += fullGains;
      //       potentialP2shSegwitGains +=
      //           fullGains - (isP2pkh ? P2SH_P2WPKH_COST : P2SH_P2WSH_COST);
      //       break;
      //     }
      // }

      if (isP2tr) {
        if (vin.witness!.length == 1) {
          realizedTaprootGains += 42;
        } else {}
      } else {
        final script = isP2shP2Wsh || isP2wsh ? vin.inner_witnessscript_asm : vin.inner_redeemscript_asm;
        var replacementSize = 0;
        if (
            // single sig
            isP2pk ||
                isP2pkh ||
                isP2wpkh ||
                isP2shP2Wpkh ||
                // multisig
                isBareMultisig ||
                parseMultisigScript(script!) != null) {
          // the scriptSig and scriptWitness can all be replaced by a 66 witness WU with taproot
          replacementSize = 66;
        } else {
          final spendingPaths = script.split(' ').where((op) => RegExp(r'^(OP_IF|OP_NOTIF)$').hasMatch(op)).length + 1;
          // now assume the script could have been split into ${spendingPaths} equal tapleaves
          replacementSize = int.parse((script.length ~/ 2 ~/ spendingPaths + 32 * math.log((spendingPaths - 1) + 1) + 33).toString());

          potentialTaprootGains += witnessSize(vin) + scriptSigSize(vin) * 4 - replacementSize;
        }
      }
    }
    return {
      'realizedSegwitGains': realizedSegwitGains / (tx.weight! + realizedSegwitGains), // percent of the pre-segwit tx size
      'potentialSegwitGains': potentialSegwitGains / tx.weight!,
      'potentialP2shSegwitGains': potentialP2shSegwitGains / tx.weight!,
      'potentialTaprootGains': potentialTaprootGains / tx.weight!,
      'realizedTaprootGains': realizedTaprootGains / (tx.weight! + realizedTaprootGains),
    };
  }

  void calculateRatings(TransactionConfirmedDetail block) {
    num feePerByte = effectiveFeeRate.value == 0.0 ? (transactionModel!.fee! / (transactionModel!.weight! / 4)) : effectiveFeeRate.value;
    medianFeeNeeded = int.parse(
      block.extras.medianFee.toString(),
    );

    // Block not filled
    if (block.weight < 4000000 * 0.95) {
      medianFeeNeeded = 1;
    }

    overpaidTimes = (feePerByte / medianFeeNeeded!).round();
    print(overpaidTimes);
    print('overpaid times ');

    if (feePerByte <= medianFeeNeeded! || overpaidTimes! < 2) {
      feeRating.value = 1;
    } else {
      feeRating.value = 2;
      if (overpaidTimes! > 10) {
        feeRating.value = 3;
      }
    }
    print(feeRating.value);
  }

  txDetailsConfirmedF(String block) async {
    try {
      String url = 'https://mempool.space/api/v1/block/$block';
      print(url);
      final response = await dioClient.get(url: url);
      print(response);
      final txDetailsConfirmed = TransactionConfirmedDetail.fromJson(
        jsonDecode(jsonEncode(response.data)),
      );
      calculateRatings(txDetailsConfirmed);
      isLoading.value = false;
      update();
    } on DioException {
      isLoading.value = false;
      update();
    } catch (e, tr) {
      print(tr);
      print(e);
      isLoading.value = false;
      update();
    }
  }

  RxInt? blockHeight;
  getSingleTransaction(String txID) async {
    try {
      print('get single transaction called ');
      isLoading.value = true;
      String url = '${baseUrl}tx/$txID';
      await dioClient
          .get(url: url)
          .then((value) async {
            transactionModel = TransactionModel.fromJson(value.data);
            // for(int i = 0 ; i< transactionModel!.vin!.length;i++){
            //   inputDollar.add(0.0);
            // }
            height = transactionModel!.status!.blockHeight;
            final homeController = Get.find<HomeController>();
            chainTip = homeController.bitcoinData.first.height;
            // print(height);
            // print(chainTip);
            print('before calculating confirmations');
            List<String> addresses = List.empty(growable: true);
            for (Vin vin in (transactionModel!.vin ?? [])) {
              if (vin.prevout != null && vin.prevout!.scriptpubkeyAddress != null) {
                addresses.add(vin.prevout!.scriptpubkeyAddress!);
              }
            }
            for (Prevout vout in (transactionModel!.vout ?? [])) {
              if (vout.scriptpubkeyAddress != null) {
                addresses.add(vout.scriptpubkeyAddress!);
              }
            }
            await checkAddressesOwnership(addresses).then((val) {
              currentOwnedAddresses = List.empty(growable: true);
              for (String k in val.data.keys) {
                bool owned = val.data[k];
                if (owned) {
                  currentOwnedAddresses.add(k);
                }
              }
            });
            await calculateConfirmation();
            await calculateStatus(transactionModel!.status!.confirmed!);
            // print(
            //     'above is the current block size${transactionModel!.status!.blockHeight}');
            // await txDetailsConfirmedF(
            //     transactionModel!.status!.blockHeight!.toString());
          })
          .then((value) => dollarRate())
          .then(
            (value) {
              segwitEnabled.value = !transactionModel!.status!.confirmed! ||
                  AppUtils.isFeatureActive('mainnet', transactionModel!.status!.blockHeight!, 'segwit');
              rbfEnabled.value = !transactionModel!.status!.confirmed! ||
                  AppUtils.isFeatureActive('mainnet', transactionModel!.status!.blockHeight!, 'rbf');
              taprootEnabled.value = !transactionModel!.status!.confirmed! ||
                  AppUtils.isFeatureActive('mainnet', transactionModel!.status!.blockHeight!, 'taproot');
              calcSegwitFeeGains(transactionModel!);
              // ids.first = transactionModel!.txid!;
              getOutSpends1();
              isRbfTransaction.value = transactionModel!.vin!.any((element) => element.sequence! < 0xfffffffe);
              isTaproot.value = transactionModel!.vin!.any((v) => v.prevout != null && v.prevout!.scriptpubkeyType == 'v1_p2tr');
            },
          )
          .then((value) => startUpdatingTimestamp())
          .then((value) async {
            await totalBTC();
          });

      num bitCoin = transactionModel!.fee! / 100000000;

      DateTime date = DateTime.fromMillisecondsSinceEpoch(transactionModel!.status!.blockTime!.toInt() * 1000);
      requestTime.value = DateFormat('yyyy-MM-dd HH:mm').format(date);
      feeUsd = (bitCoin * currentUSD.value).toStringAsFixed(2);
      feeSat = (double.parse(feeUsd) / transactionModel!.size!).toStringAsFixed(2);
      isLoading.value = false;
    } catch (e, tr) {
      isLoading.value = false;
      print(e);
      print(tr);
    }
  }

  transactionHex() async {
    getHexValue.value = !getHexValue.value;
    if (!getHexValue.value) {
      String url = '${baseUrl}tx/$txID/hex';
      final response = await dioClient.get(url: url);
      hexValue.value = response.data;
    }
  }

  dollarRate() async {
    DateTime now = DateTime.now();

    int timestamp = now.millisecondsSinceEpoch;

    String url = '${baseUrl}v1/historical-price?timestamp=$timestamp';

    final response = await dioClient.get(url: url);
    if (response.statusCode == 200) {
      final data = response.data;
      final List<dynamic> prices = data['prices'];
      if (prices.isNotEmpty) {
        final latestPrice = prices.last;
        // currentUSD.value = latestPrice['USD'];
        usdValue.value = (transactionModel!.fee! / 100000000) * latestPrice['USD'];
        feeRate.value = transactionModel!.fee! / transactionModel!.weight!;
      }
    } else {
      throw Exception('Failed to load historical price');
    }
    currentUSD.value = homeController.currentUSD.value;
    update();
  }

  RxDouble totalOutPutBTC = 0.0.obs;
  RxDouble totalOutPutDollar = 0.0.obs;

  Future<void> totalBTC() async {
    double total = 0.0;
    for (int i = 0; i < transactionModel!.vout!.length; i++) {
      total = (transactionModel!.vout?[i].value!)! / 100000000 + total;
      totalOutPutBTC.value = total;
    }
  }

  outPutDollars() async {
    totalOutPutDollar.value = totalOutPutBTC.value * currentUSD.value;
  }

  String formatLocalTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

    // Format DateTime to the desired format
    RxString formattedDateTime = "${dateTime.toLocal()}".split('.')[0].obs;
    return formattedDateTime.value;
  }

  String formatTimestamp(int timestamp) {
    final now = DateTime.now();
    final time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    final difference = now.difference(time);
    if (difference.inMinutes < 1) {
      return 'Just Now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours <= 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays <= 365) {
      final days = difference.inDays;
      return '$days days ago';
    } else {
      final years = difference.inDays ~/ 365;
      return '$years years ago';
    }
  }

  getSubTransaction() async {
    print('call api');
    try {
      isLoading.value = true;
      String url = '${baseUrl}address/$addressId/txs';
      log(url);
      // Timer.periodic(Duration(seconds: 5), (timer) async {
      await dioClient
          .get(url: url)
          .then((value) async {
            subTransactionModel.clear();
            ids.clear();
            for (int i = 0; i < value.data.length; i++) {
              subTransactionModel.add(TransactionModel.fromJson(value.data[i]));
              ids.add(subTransactionModel[i].txid!);
            }

            await getOutSpends();
          })
          .then((value) => dollarRate())
          // .then((value) => startUpdatingTimestamp())
          .then((value) async {
            await totalBTC();
          });

      isLoading.value = false;
      //     });
    } catch (e) {
      print('catch $e');
      isLoading.value = false;
    }
  }

  getOutSpends1() async {
    try {
      isLoadingOutSpends.value = true;
      String url = 'https://mempool.space/api/txs/outspends?txids=${txID}';
      log(url);
      dataOutSpents1 = await dioClient.get(url: url);
      print(dataOutSpents1);
    } catch (e) {
      print(e);
    }
  }

  getOutSpends() async {
    int turns = ids.length ~/ 10 + 1;
    print('turns $turns');
    try {
      isLoadingOutSpends.value = true;
      String url = 'https://mempool.space/api/txs/outspends?txids=${ids.length > 10 ? ids.sublist(0, 10).join(",") : ids.join(",")}';
      log(url);
      dataOutSpents = await dioClient.get(url: url);
      isLoadingOutSpends.value = false;
    } catch (e) {
      isLoadingOutSpends.value = false;
    }
  }

  getSubMoreTransaction() async {
    print('call api');
    try {
      isLoading.value = true;
      String url = '${baseUrl}address/$addressId/txs?after_txid=${subTransactionModel[10].txid}';
      // Timer.periodic(Duration(seconds: 5), (timer) async {
      await dioClient
          .get(url: url)
          .then((value) async {
            subTransactionModel.clear();
            ids.clear();
            for (int i = 0; i < value.data.length; i++) {
              subTransactionModel.add(TransactionModel.fromJson(value.data[i]));
              ids.add(subTransactionModel[i].txid!);
            }
            await getOutSpends();
          })
          .then((value) => dollarRate())
          // .then((value) => startUpdatingTimestamp())
          .then((value) async {
            await totalBTC();
          });

      isLoading.value = false;
      //     });
    } catch (e) {
      print('catch $e');
      isLoading.value = false;
    }
  }

  transactionTrack() {
    channel.sink.add('{"track-rbf-summary":false}');
    channel.sink.add('{"action":"want","data":["blocks","mempool-blocks"]}');
    channel.sink.add('{"action":"want","data":["blocks","mempool-blocks"]}');
    channel.sink.add('{"track-tx":"${txID}"}');
    Future.delayed(
      const Duration(minutes: 3),
      () {
        channel.sink.add('{"action":"ping"}');
      },
    );
  }

  // subTransactionTrack() {
  //   print('add_address $addressId');
  //   channel.sink.add('{"track-tx":"stop"}');
  //   channel.sink.add('{"action":"want","data":["blocks"]]}');
  //   channel.sink.add('{"track-address":"$addressId"}');
  //   print('add_address $addressId');
  //
  //   Future.delayed(
  //     const Duration(minutes: 3),
  //     () {
  //       channel.sink.add('{"action":"ping"}');
  //     },
  //   );
  // }

  int calculateAddressValue(TransactionModel tx) {
    bool isP2PKUncompressed = addressId.length == 130;
    bool isP2PKCompressed = addressId.length == 66;
    if (isP2PKCompressed) {
      print('1');
      int addressIn = tx.vout!.where((v) => v.scriptpubkeyAddress == '21${addressId}ac').map((v) => v.value ?? 0).fold(0, (a, b) => a + b);

      int addressOut = tx.vin!
          .where((v) => v.prevout!.scriptpubkeyAddress == '21${addressId}ac')
          .map((v) => v.prevout!.value ?? 0)
          .fold(0, (a, b) => a + b);

      return addressIn - addressOut;
    } else if (isP2PKUncompressed) {
      print('2');
      int addressIn = tx.vout!.where((v) => v.scriptpubkeyAddress == '41${addressId}ac').map((v) => v.value ?? 0).fold(0, (a, b) => a + b);

      int addressOut = tx.vin!
          .where((v) => v.prevout!.scriptpubkeyAddress == '41${addressId}ac')
          .map((v) => v.prevout!.value ?? 0)
          .fold(0, (a, b) => a + b);

      return addressIn - addressOut;
    } else {
      print('3');
      print(tx.vin![0].prevout!.scriptpubkey);
      int addressIn = tx.vout!.where((v) => v.scriptpubkeyAddress == addressId).map((v) => v.value ?? 0).fold(0, (a, b) => a + b);

      int addressOut =
          tx.vin!.where((v) => v.prevout!.scriptpubkeyAddress == addressId).map((v) => v.prevout!.value ?? 0).fold(0, (a, b) => a + b);

      print(addressIn);
      print(addressOut);
      return addressIn - addressOut;
    }
  }
}

class SegwitFeeGains {
  double realizedSegwitGains = 0.0;
  double potentialSegwitGains = 0.0;
  double potentialP2shSegwitGains = 0.0;
  double potentialTaprootGains = 0.0;
  double realizedTaprootGains = 0.0;

  SegwitFeeGains();

  SegwitFeeGains.fromJson(Map<String, dynamic> json) {
    realizedSegwitGains = (json['realizedSegwitGains'] as double);
    potentialSegwitGains = (json['potentialSegwitGains'] as double);
    potentialP2shSegwitGains = (json['potentialP2shSegwitGains'] as double);
    potentialTaprootGains = (json['potentialTaprootGains'] as double);
    realizedTaprootGains = (json['realizedTaprootGains'] as double);
  }

  Map<String, dynamic> toJson() {
    return {
      'realizedSegwitGains': realizedSegwitGains,
      'potentialSegwitGains': potentialSegwitGains,
      'potentialP2shSegwitGains': potentialP2shSegwitGains,
      'potentialTaprootGains': potentialTaprootGains,
      'realizedTaprootGains': realizedTaprootGains,
    };
  }
}
