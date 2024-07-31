import 'dart:math' as math;

import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/transactionitem.dart';
import 'package:bitnet/models/bitcoin/lnd/payment_model.dart';
import 'package:bitnet/models/bitcoin/lnd/received_invoice_model.dart';
import 'package:bitnet/models/bitcoin/transactiondata.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/transactions/controller/transaction_controller.dart';
import 'package:bitnet/pages/transactions/view/single_transaction_screen.dart';
import 'package:bitnet/pages/wallet/cardinfo/controller/lightning_info_controller.dart';
import 'package:bitnet/pages/wallet/component/wallet_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class LightningCardInformationScreen extends StatefulWidget {
  const LightningCardInformationScreen({super.key});

  @override
  State<LightningCardInformationScreen> createState() =>
      _LightningCardInformationScreenState();
}

class _LightningCardInformationScreenState
    extends State<LightningCardInformationScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return bitnetScaffold(
//         extendBodyBehindAppBar: true,
//         body: PopScope(
//             canPop: false,
//             onPopInvoked: (v) {
//               context.go("/feed");
//             },
//             child: Container()),
//         appBar: bitnetAppBar(
//           text: L10n.of(context)!.lightningCardInfo,
//           context: context,
//           onTap: () {
//             context.go("/feed");
//           },
//         ),
//         context: context);
//   }
// }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LightningInfoController());
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        context: context,
        onTap: () {
          context.go("/feed");
        },
        text: L10n.of(context)!.lightningCardInfo,
      ),
      context: context,
      body: PopScope(
        canPop: false,
        onPopInvoked: (v) {
          context.go("/feed");
        },
        child: Obx(
          () => controller.loadingState.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            height: 200,
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: BalanceCardLightning()),
                        const SizedBox(
                          height: AppTheme.elementSpacing,
                        ),
                        StatefulBuilder(builder: (context, setState) {
                          return Column(
                            children: [
                              SearchFieldWidget(
                                hintText: L10n.of(context)!.search,
                                handleSearch: (v) {
                                  setState(() {
                                    // controller.searchValue = v;
                                  });
                                },
                                suffixIcon: IconButton(
                                    icon: Icon(FontAwesomeIcons.filter),
                                    onPressed: () async {
                                      await BitNetBottomSheet(
                                          context: context,
                                          child: WalletFilterScreen());
                                      setState(() {});
                                    }),
                                isSearchEnabled: true,
                              ),
                              controller.lightningInvoices.isEmpty
                                  ? const Text('Loading')
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller
                                          .combinedTransactions.length,
                                      itemBuilder: (context, index) {
                                        final transaction = controller
                                            .combinedTransactions[index];
                                        if (transaction is ReceivedInvoice) {
                                          return TransactionItem(
                                            context: context,
                                            data: TransactionItemData(
                                              timestamp: transaction.settleDate,
                                              type: TransactionType.lightning,
                                              direction:
                                                  TransactionDirection.received,
                                              receiver: transaction
                                                  .paymentRequest
                                                  .toString(),
                                              txHash:
                                                  transaction.value.toString(),
                                              amount: "+" +
                                                  transaction.amtPaid
                                                      .toString(),
                                              fee: 0,
                                              status: transaction.settled
                                                  ? TransactionStatus.confirmed
                                                  : TransactionStatus.failed,
                                            ),
                                          );
                                        } else if (transaction
                                            is LightningPayment) {
                                          return TransactionItem(
                                            context: context,
                                            data: TransactionItemData(
                                              timestamp:
                                                  transaction.creationDate,
                                              type: TransactionType.lightning,
                                              direction:
                                                  TransactionDirection.sent,
                                              receiver: transaction
                                                  .paymentRequest
                                                  .toString(),
                                              txHash: transaction.paymentHash
                                                  .toString(),
                                              amount: "-" +
                                                  transaction.value.toString(),
                                              fee: transaction.fee,
                                              status: transaction.status ==
                                                      'SUCCEEDED'
                                                  ? TransactionStatus.confirmed
                                                  : TransactionStatus.failed,
                                            ),
                                          );
                                        }
                                        return SizedBox.shrink();
                                      },
                                    ),
                            ],
                          );
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
