
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/bitcoin/lnd/subserverinfo.dart';

import 'package:bitnet/models/currency/bitcoinunitmodel.dart';

import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings.dart';

import 'package:bitnet/pages/wallet/controllers/wallet_controller.dart';
import 'package:bitnet/pages/wallet/loop/loop_controller.dart';


import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class WalletScreen extends GetWidget<WalletsController> {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WalletsController walletController = Get.put(WalletsController());
    ProfileController profileController = Get.put(ProfileController());
    // We'll introduce a local state using a StatefulBuilder.
    // Alternatively, you could create a StatefulWidget from scratch.
    return bitnetScaffold(
      context: context,
      body: StatefulBuilder(
        builder: (context, setState) {
          SubServersStatus?
              subServersStatus; // local variable to store fetched data

          // We'll return a CustomScrollView but we need a persistent state
          // Let's define these variables outside the build to avoid losing data:
          return CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Obx(
                  () {
                    controller.chartLines.value;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppTheme.cardPadding * 1.5),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding * 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  profileController.isNull
                                      ? Avatar(
                                          isNft: false,
                                        )
                                      : Avatar(
                                          size: AppTheme.cardPadding * 2.5.h,
                                          mxContent: Uri.parse(profileController
                                              .userData.value.profileImageUrl),
                                          type: profilePictureType.lightning,
                                          isNft: profileController.userData
                                              .value.nft_profile_id.isNotEmpty),
                                  SizedBox(
                                    width: AppTheme.elementSpacing * 1.25.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        L10n.of(context)!.totalWalletBal,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(
                                          height:
                                              AppTheme.elementSpacing * 0.25),
                                      Obx(
                                        () => Row(
                                          children: [
                                            controller.hideBalance.value
                                                ? Text(
                                                    '*****',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall,
                                                  )
                                                : Obx(() {
                                                    final chartLine = controller
                                                        .chartLines.value;
                                                    final bitcoinPrice =
                                                        chartLine?.price;
                                                    final currencyEquivalent =
                                                        bitcoinPrice != null
                                                            ? (controller
                                                                        .totalBalanceSAT
                                                                        .value /
                                                                    100000000 *
                                                                    bitcoinPrice)
                                                                .toStringAsFixed(
                                                                    2)
                                                            : "0.00";

                                                    final coin = Provider.of<
                                                            CurrencyTypeProvider>(
                                                        context,
                                                        listen: true);
                                                    final currency = Provider
                                                        .of<CurrencyChangeProvider>(
                                                            context,
                                                            listen: true);
                                                    controller.coin.value = coin
                                                            .coin ??
                                                        controller.coin.value;
                                                    controller.selectedCurrency
                                                        ?.value = currency
                                                            .selectedCurrency ??
                                                        controller
                                                            .selectedCurrency!
                                                            .value;

                                                    return GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .setCurrencyType(
                                                                !controller
                                                                    .coin.value,
                                                                updateDatabase:
                                                                    false);
                                                        coin.setCurrencyType(
                                                            controller
                                                                .coin.value);
                                                      },
                                                      child: (controller
                                                              .coin.value)
                                                          ? Row(
                                                              children: [
                                                                Text(
                                                                  controller
                                                                      .totalBalance
                                                                      .value
                                                                      .amount
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .displaySmall,
                                                                ),
                                                                Icon(getCurrencyIcon(
                                                                    controller
                                                                        .totalBalance
                                                                        .value
                                                                        .bitcoinUnitAsString)),
                                                              ],
                                                            )
                                                          : Text(
                                                              "$currencyEquivalent${getCurrency(controller.selectedCurrency == null ? '' : controller.selectedCurrency!.value)}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displaySmall,
                                                            ),
                                                    );
                                                  }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Obx(
                                    () => RoundedButtonWidget(
                                      size: AppTheme.cardPadding * 1.25,
                                      buttonType: ButtonType.transparent,
                                      iconData:
                                          controller.hideBalance.value == false
                                              ? FontAwesomeIcons.eyeSlash
                                              : FontAwesomeIcons.eye,
                                      onTap: () {
                                        controller.setHideBalance(
                                            hide:
                                                !controller.hideBalance.value);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppTheme.elementSpacing * 0.75.w,
                                  ),
                                  RoundedButtonWidget(
                                    size: AppTheme.cardPadding * 1.25,
                                    buttonType: ButtonType.transparent,
                                    iconData: Icons.settings,
                                    onTap: () {
                                      BitNetBottomSheet(
                                        width: double.infinity,
                                        //height: MediaQuery.of(context).size.height * 0.7,
                                        context: context,
                                        borderRadius: AppTheme.borderRadiusBig,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .canvasColor, // Add a background color here
                                            borderRadius: new BorderRadius.only(
                                              topLeft: AppTheme.cornerRadiusBig,
                                              topRight:
                                                  AppTheme.cornerRadiusBig,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: new BorderRadius.only(
                                              topLeft: AppTheme.cornerRadiusBig,
                                              topRight:
                                                  AppTheme.cornerRadiusBig,
                                            ),
                                            child: Settings(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: AppTheme.cardPadding.h * 1.5,
                        ),
                        Container(
                          height: AppTheme.cardPadding * 7.75.h,
                          child: Stack(
                            children: [
                              CardSwiper(
                                backCardOffset: const Offset(
                                    0, -AppTheme.elementSpacing * 1.25),
                                numberOfCardsDisplayed:
                                    2, // Updated from 3 to 2
                                padding: const EdgeInsets.only(
                                    left: AppTheme.cardPadding,
                                    right: AppTheme.cardPadding,
                                    top: AppTheme.cardPadding),
                                scale: 1.0,
                                initialIndex: controller.selectedCard.value ==
                                        'onchain'
                                    ? 1 // Updated index after removing FiatCard
                                    // : controller.selectedCard.value == 'fiat'
                                    //     ? 1
                                    : 0,
                                cardsCount: 2, // Updated from 3 to 2
                                onSwipe: (int index, int? previousIndex,
                                    CardSwiperDirection direction) {
                                  controller.setSelectedCard(previousIndex == 1
                                      ? 'onchain'
                                      // : previousIndex == 1
                                      //     ? 'fiat'
                                      : 'lightning');
                                  return true;
                                },
                                cardBuilder: (context, index, percentThresholdX,
                                    percentThresholdY) {
                                  List<Widget> cards = [
                                    GestureDetector(
                                      onTap: () {
                                        context.go('/wallet/lightningcard');
                                      },
                                      child: Obx(() {
                                        // Extracting reactive variables from the controller

                                        final confirmedBalanceStr =
                                            walletController
                                                .lightningBalance.value.balance;
                                        final unconfirmedBalanceStr =
                                            walletController.onchainBalance
                                                .value.unconfirmedBalance;

                                        return BalanceCardLightning(
                                          balance: confirmedBalanceStr,
                                          confirmedBalance: confirmedBalanceStr,
                                          defaultUnit: BitcoinUnits
                                              .SAT, // You can adjust this as needed
                                        );
                                      }),
                                    ),
                                    // // Uncomment the below GestureDetector to reactivate the FiatCard
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     context.go('/wallet/fiatcard');
                                    //   },
                                    //   child: const FiatCard(),
                                    // ),
                                    GestureDetector(
                                      onTap: () {
                                        context.go('/wallet/bitcoincard');
                                      },
                                      child: Obx(() {
                                        final logger =
                                            Get.find<LoggerService>();
                                        // Extracting reactive variables from the controller

                                        final confirmedBalanceStr =
                                            walletController.onchainBalance
                                                .value.confirmedBalance;
                                        final unconfirmedBalanceStr =
                                            walletController.onchainBalance
                                                .value.unconfirmedBalance;

                                        logger.i(
                                            "Confirmed Balance onchain: $confirmedBalanceStr");
                                        logger.i(
                                            "Unconfirmed Balance onchain: $unconfirmedBalanceStr");

                                        return BalanceCardBtc(
                                          balance: confirmedBalanceStr,
                                          confirmedBalance: confirmedBalanceStr,
                                          unconfirmedBalance:
                                              unconfirmedBalanceStr,
                                          defaultUnit: BitcoinUnits.SAT,
                                        );
                                      }),
                                    ),
                                  ];
                                  return cards[index];
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Add our new button here
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LongButtonWidget(title: "fetch Lightning Balance", onTap: () async {
                      //   await controller.fetchLightingWalletBalance();
                      // }),
                      // SizedBox(height: AppTheme.cardPadding.h * 1.75),
                      // LongButtonWidget(
                      //   title: "list Unspent",
                      //   onTap: () async {
                      //     final bitcoinReceiverAdress = "bc1pt4kgverny8jhutqljjcqaanf2hncuxczx0dj83ulpr3ey5e0q00splw8zw";
                      //     final amountInSat = 1;
                      //     final logger = Get.find<LoggerService>();
                      //
                      //     logger.i("Sending Onchain Payment to: $bitcoinReceiverAdress");
                      //
                      //     // logger.i("Fetching addresses from LND...");
                      //     // RestResponse listAddressesResponse =
                      //     // await listAddressesLnd(Auth().currentUser!.uid);
                      //
                      //     // AccountWithAddresses account = AccountWithAddresses.fromJson(
                      //     //     (listAddressesResponse.data['account_with_addresses'] as List)
                      //     //         .firstWhereOrNull(
                      //     //             (acc) => acc['name'] == Auth().currentUser!.uid));
                      //     //
                      //     // logger.i("Addresses fetched successfully.");
                      //     // List<String> changeAddresses = account.addresses
                      //     //     .where((test) => test.isInternal)
                      //     //     .map((test) => test.address)
                      //     //     .toList();
                      //     //
                      //     // List<String> nonChangeAddresses = account.addresses
                      //     //     .where((test) => !test.isInternal)
                      //     //     .map((test) => test.address)
                      //     //     .toList();
                      //
                      //     dynamic restResponseListUnspent = await listUnspent(Auth().currentUser!.uid);
                      //     UtxoRequestList utxos = UtxoRequestList.fromJson(restResponseListUnspent.data);
                      //
                      //     logger.i("UTXOs fetched successfully: $restResponseListUnspent");
                      //
                      //
                      //     TransactionData transactiondata = TransactionData(
                      //         raw: RawTransactionData(
                      //           inputs: utxos.utxos
                      //               .map((i) => Input(
                      //             txidStr: i.outpoint.txidStr,
                      //             txidBytes: i.outpoint.txidBytes,
                      //             outputIndex: i.outpoint.outputIndex,
                      //           ))
                      //               .toList(),
                      //           outputs: Outputs(
                      //               outputs: {bitcoinReceiverAdress: amountInSat.toInt()}),
                      //         ),
                      //         targetConf: AppTheme
                      //             .targetConf, //The number of blocks to aim for when confirming the transaction.
                      //         account: "",
                      //         minConfs:
                      //         4, //going for safety and not speed because for speed oyu would use the lightning network
                      //         spendUnconfirmed:
                      //         false, //Whether unconfirmed outputs should be used as inputs for the transaction.
                      //         changeType: 0 //CHANGE_ADDRESS_TYPE_UNSPECIFIED
                      //     );
                      //
                      //     logger.i("Transaction data created successfully.");
                      //
                      //     logger.i("getting local privateData");
                      //     PrivateData privData = await getPrivateData(Auth().currentUser!.uid);
                      //
                      //     logger.i("Reriving fee now...");
                      //     dynamic feeResponse =
                      //     await estimateFee(AppTheme.targetConf.toString());
                      //
                      //     final sat_per_kw = double.parse(feeResponse.data["sat_per_kw"]);
                      //     double utxoSum = 0;
                      //     for (Utxo utxo in utxos.utxos) {
                      //       utxoSum += utxo.amountSat;
                      //     }
                      //
                      //     logger.i("utxoSum: $utxoSum");
                      //     logger.i("sat_per_kw: $sat_per_kw");
                      //
                      //     String changeAddress = await nextAddr(Auth().currentUser!.uid, change: true);
                      //     logger.i("Change address: $changeAddress");
                      //
                      //     logger.i("This is our mnemonic: ${privData.mnemonic}");
                      //
                      //
                      //     logger.i("make HD Wallet");
                      //     HDWallet hdWallet = HDWallet.fromMnemonic(privData.mnemonic);
                      //
                      //     print("Wif private key: ${hdWallet.privkey}");
                      //
                      //
                      //     // logger.i("Building transaction...");
                      //     //
                      //     // final builder = BitcoinTransactionBuilder(
                      //     //     outPuts: [
                      //     //       BitcoinOutput(
                      //     //           address: parseBitcoinAddress(bitcoinReceiverAdress),
                      //     //           value: BigInt.from(amountInSat.toInt())),
                      //     //       BitcoinOutput(
                      //     //           address: parseBitcoinAddress(changeAddress),
                      //     //           value: BigInt.from(
                      //     //               utxoSum - (amountInSat.toInt() + sat_per_kw)))
                      //     //     ],
                      //     //
                      //     //     fee: BigInt.from(sat_per_kw),
                      //     //     network: BitcoinNetwork.mainnet,
                      //     //     utxos: utxos.utxos
                      //     //         .map((utxo) => UtxoWithAddress(
                      //     //         utxo: BitcoinUtxo(
                      //     //             txHash: utxo.outpoint.txidStr,
                      //     //             value: BigInt.from(utxo.amountSat),
                      //     //             vout: utxo.outpoint.outputIndex,
                      //     //             scriptType: parseBitcoinAddress(utxo.address).type),
                      //     //         ownerDetails: UtxoAddressDetails(
                      //     //             publicKey: hdWallet
                      //     //                 .findKeyPair(
                      //     //               utxo.address,
                      //     //               privData.mnemonic,
                      //     //               changeAddresses.contains(utxo.address) ? 1 : 0,
                      //     //             )
                      //     //                 .getPublic()
                      //     //                 .publicKey
                      //     //                 .toHex(),
                      //     //             address: parseBitcoinAddress(utxo.address))))
                      //     //         .toList());
                      //
                      //     // dynamic fundPsbtrestResponse =
                      //     //     await fundPsbt(transactiondata, Auth().currentUser!.uid);
                      //     //
                      //     // FundedPsbtResponse fundedPsbtResponse =
                      //     //     FundedPsbtResponse.fromJson(fundPsbtrestResponse.data);
                      //
                      //     // logger.i("Funded ${fundedPsbtResponse.fundedPsbt}");
                      //
                      //     //Lnd must be the last signer of the transaction. That means, if there are any unsigned non-witness inputs or inputs without UTXO information attached or inputs without witness data that do not belong to lnd's wallet, this method will fail.
                      //     // dynamic finalizedPsbtRestResponse =
                      //     //     await signPsbt(fundedPsbtResponse.fundedPsbt);
                      //     // FinalizePsbtResponse finalizedPsbtResponse =
                      //     //     FinalizePsbtResponse.fromJson(finalizedPsbtRestResponse.data);
                      //
                      //     //replace this here with own signature service copied
                      //
                      //     //After this we can essentially use publishtransaction again I belive
                      //     logger.i("Building transaction...");
                      //     // final tr = builder.buildTransaction((trDigest, utxo, publicKey, sighash) {
                      //     //   String address =
                      //     //   utxo.ownerDetails.address.toAddress(BitcoinNetwork.mainnet);
                      //     //   final ECPrivate privateKey = hdWallet.findKeyPair(
                      //     //     address,
                      //     //     privData.mnemonic,
                      //     //     changeAddresses.contains(address) ? 1 : 0,
                      //     //   );
                      //     //   return privateKey.signInput(trDigest, sigHash: sighash);
                      //     // });
                      //     // final txId = tr.serialize();
                      //     // logger.i("Transaction ID: $txId");
                      //     // RestResponse publishTransactionRestResponse =
                      //     //     await broadcastTransaction(txId); //txhex and label
                      //     // const network = BitcoinNetwork.mainnet;
                      //
                      //     /// Define http provider and api provider
                      //     // logger.i("Creating BitcoinApiService...");
                      //     // final service = BitcoinApiService();
                      //     // final api = ApiProvider.fromBlocCypher(network, service);
                      //     // logger.i("Sending raw transaction: ${tr.serialize()}");
                      //     //
                      //     // String response = await api.sendRawTransaction(tr.serialize());
                      //     // logger.i("Response from sendRawTransaction server: $response");
                      //
                      //   },
                      // ),
                      // SizedBox(height: AppTheme.cardPadding.h * 1.75),
                      // LongButtonWidget(
                      //   title: "subscribeToOnchainBalance ",
                      //   onTap: () async {
                      //     await controller.subscribeToOnchainBalance();
                      //   },
                      // ),
                      // SizedBox(height: AppTheme.cardPadding.h * 1.75),
                      // LongButtonWidget(
                      //   title: "${Auth().currentUser!.uid}",
                      //   onTap: () async {
                      //     await controller.subscribeToOnchainTransactions();
                      //   },
                      // ),
                      // SizedBox(height: AppTheme.cardPadding.h * 1.75),
                      // LongButtonWidget(
                      //   title: "Genlitdaccount",
                      //   onTap: () async {
                      //     String did = Auth().currentUser!.uid;
                      //     await Auth().genLitdAccount(did);
                      //   },
                      // ),
                      // SizedBox(height: AppTheme.cardPadding.h * 1.75),
                      // LongButtonWidget(
                      //   title: "Show Server Status",
                      //   onTap: () async {
                      //     await controller.updateSubServerStatus();
                      //   },
                      // ),
                      //
                      // SizedBox(height: AppTheme.cardPadding.h),
                      //
                      // // Observe the subServersStatus variable
                      // Obx(() {
                      //   final status = controller.subServersStatus.value;
                      //   if (status == null) {
                      //     // If null, either not fetched yet or failed
                      //     return Text(
                      //         "No status fetched yet or failed to load.",
                      //         style: Theme.of(context).textTheme.bodyMedium);
                      //   }
                      //
                      //   // If we have status data, show the DataTable
                      //   return Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text("Service Status Overview:",
                      //           style: Theme.of(context).textTheme.titleLarge),
                      //       SizedBox(height: AppTheme.cardPadding.h),
                      //       DataTable(
                      //         columns: const [
                      //           DataColumn(label: Text("Service")),
                      //           DataColumn(label: Text("Disabled")),
                      //           DataColumn(label: Text("Running")),
                      //           DataColumn(label: Text("Error")),
                      //         ],
                      //         rows: status.subServers.entries.map((entry) {
                      //           final serviceName = entry.key;
                      //           final info = entry.value;
                      //
                      //           Color disabledColor =
                      //               info.disabled ? Colors.red : Colors.green;
                      //           Color runningColor =
                      //               info.running ? Colors.green : Colors.red;
                      //           Color errorColor = info.error.isNotEmpty
                      //               ? Colors.red
                      //               : Colors.green;
                      //
                      //           return DataRow(cells: [
                      //             DataCell(Text(serviceName)),
                      //             DataCell(Text(info.disabled.toString(),
                      //                 style: TextStyle(color: disabledColor))),
                      //             DataCell(Text(info.running.toString(),
                      //                 style: TextStyle(color: runningColor))),
                      //             DataCell(Text(
                      //                 info.error.isEmpty
                      //                     ? "No Error"
                      //                     : info.error,
                      //                 style: TextStyle(color: errorColor))),
                      //           ]);
                      //         }).toList(),
                      //       ),
                      //     ],
                      //   );
                      // }),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppTheme.cardPadding.h * 1.75),
                      Text(L10n.of(context)!.actions,
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: AppTheme.cardPadding.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BitNetImageWithTextButton(
                            L10n.of(context)!.send,
                            () {
                              context.go('/wallet/send');
                            },
                            image: "assets/images/send_image.png",
                            width: AppTheme.cardPadding * 3.5.w,
                            height: AppTheme.cardPadding * 3.5.w,
                            fallbackIcon: Icons.arrow_upward_rounded,
                          ),
                          BitNetImageWithTextButton(
                            L10n.of(context)!.receive,
                            () {
                              context.go(
                                  '/wallet/receive/${controller.selectedCard.value}');
                            },
                            image: "assets/images/receive_image.png",
                            width: AppTheme.cardPadding * 3.5.w,
                            height: AppTheme.cardPadding * 3.5.w,
                            fallbackIcon: Icons.arrow_downward_rounded,
                          ),
                          BitNetImageWithTextButton(
                            "Swap",
                            () {
                              Get.put(LoopsController());
                              context.go("/wallet/loop_screen");
                            },
                            image: "assets/images/rebalance_image.png",
                            width: AppTheme.cardPadding * 3.5.w,
                            height: AppTheme.cardPadding * 3.5.w,
                            fallbackIcon: Icons.sync_rounded,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // The rest of your code remains unchanged
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppTheme.cardPadding.h * 1.75),
                      Text(L10n.of(context)!.buySell,
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: AppTheme.cardPadding.h),
                      CryptoItem(
                        currency: Currency(
                          code: 'BTC',
                          name: 'Bitcoin',
                          icon: Image.asset("assets/images/bitcoin.png"),
                        ),
                        context: context,
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: StatefulBuilder(builder: (context, setStateInner) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppTheme.cardPadding.h * 1.75),
                        Text(L10n.of(context)!.activity,
                            style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(height: AppTheme.elementSpacing.h),
                      ],
                    ),
                  );
                }),
              ),
              Transactions(
                scrollController: controller.scrollController,
              )
            ],
          );
        },
      ),
    );
  }
}
