import 'package:bitnet/backbone/auth/storePrivateData.dart';
import 'package:bitnet/backbone/auth/walletunlock_controller.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/stop_ecs_task.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/create_challenge.dart';
import 'package:bitnet/backbone/cloudfunctions/sign_verify_auth/verify_message.dart';
import 'package:bitnet/backbone/helper/currency/currency_converter.dart';
import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/social_recovery_helper.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/currency_type_provider.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/items/balancecard.dart';
import 'package:bitnet/components/items/cryptoitem.dart';
import 'package:bitnet/components/resultlist/transactions.dart';
import 'package:bitnet/models/bitcoin/chartline.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/models/keys/privatedata.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/wallet/actions/receive/controller/receive_controller.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
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
import 'package:bitnet/backbone/cloudfunctions/aws/start_ecs_task.dart';
import 'package:bitnet/backbone/cloudfunctions/aws/register_lits_ecs.dart';


class WalletScreen extends GetWidget<WalletsController> {
  const WalletScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReceiveController(context), fenix: true);
    Get.lazyPut(() => SendsController(context: context), fenix: true);
    final ChartLine? chartLine = controller.chartLines.value;

    if (controller.queueErrorOvelay) {
      controller.queueErrorOvelay = false;
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          controller.handleFuturesCompleted(context);
        },
      );
    }

    final bitcoinPrice = chartLine?.price;
    final currencyEquivalent =
        bitcoinPrice != null ? (controller.totalBalanceSAT.value / 100000000 * bitcoinPrice).toStringAsFixed(2) : "0.00";
    final BitcoinUnitModel unitModel =
        CurrencyConverter.convertToBitcoinUnit(double.parse(controller.onchainBalance.confirmedBalance), BitcoinUnits.SAT);
    final coin = Provider.of<CurrencyTypeProvider>(context, listen: true);
    final currency = Provider.of<CurrencyChangeProvider>(context, listen: true);
    controller.coin.value = coin.coin ?? controller.coin.value;
    controller.selectedCurrency?.value = currency.selectedCurrency ?? controller.selectedCurrency!.value;
    List<Widget> cards = [
      GestureDetector(
        onTap: () {
          context.go('/wallet/lightningcard');
        },
        child: const BalanceCardLightning(),
      ),
      GestureDetector(
        //
        onTap: () {
          context.go('/wallet/fiatcard');
        },
        child: const FiatCard(),
      ),
      GestureDetector(
        onTap: () {
          context.go('/wallet/bitcoincard');
        },
        child: const BalanceCardBtc(),
      ),
    ];

    final profilecontroller = Get.find<ProfileController>();

    return bitnetScaffold(
      context: context,
      body: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          // Section 1: Avatar and balance
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
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding * 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Avatar(
                                  size: AppTheme.cardPadding * 2.5.h,
                                  mxContent: Uri.parse(profilecontroller.userData.value.profileImageUrl),
                                  type: profilePictureType.lightning,
                                  isNft: profilecontroller.userData.value.nft_profile_id.isNotEmpty),
                              SizedBox(
                                width: AppTheme.elementSpacing * 1.25.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    L10n.of(context)!.totalWalletBal,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: AppTheme.elementSpacing * 0.25),
                                  Obx(
                                    () => Row(
                                      children: [
                                        controller.hideBalance.value
                                            ? Text(
                                                '*****',
                                                style: Theme.of(context).textTheme.displaySmall,
                                              )
                                            : Obx(() {
                                                return GestureDetector(
                                                  onTap: () {
                                                    controller.setCurrencyType(!controller.coin.value, updateDatabase: false);
                                                    coin.setCurrencyType(controller.coin.value);
                                                  },
                                                  child: (controller.coin.value)
                                                      ? Row(
                                                          children: [
                                                            Text(
                                                              controller.totalBalance.value.amount.toString(),
                                                              overflow: TextOverflow.ellipsis,
                                                              style: Theme.of(context).textTheme.displaySmall,
                                                            ),
                                                            Icon(getCurrencyIcon(controller.totalBalance.value.bitcoinUnitAsString)),
                                                          ],
                                                        )
                                                      : Text(
                                                          "${currencyEquivalent}${getCurrency(controller.selectedCurrency == null ? '' : controller.selectedCurrency!.value)}",
                                                          style: Theme.of(context).textTheme.displaySmall,
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
                          Obx(
                            () => RoundedButtonWidget(
                              size: AppTheme.cardPadding * 1.25,
                              buttonType: ButtonType.transparent,
                              iconData: controller.hideBalance.value == false ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                              onTap: () {
                                controller.setHideBalance(hide: !controller.hideBalance.value);
                              },
                            ),
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
                            backCardOffset: const Offset(0, -AppTheme.elementSpacing * 1.25),
                            numberOfCardsDisplayed: 3,
                            padding:
                                const EdgeInsets.only(left: AppTheme.cardPadding, right: AppTheme.cardPadding, top: AppTheme.cardPadding),
                            scale: 1.0,
                            initialIndex: controller.selectedCard.value == 'onchain'
                                ? 2
                                : controller.selectedCard.value == 'fiat'
                                    ? 1
                                    : 0,
                            cardsCount: cards.length,
                            onSwipe: (int index, int? previousIndex, CardSwiperDirection direction) {
                              controller.setSelectedCard(previousIndex == 2
                                  ? 'onchain'
                                  : previousIndex == 1
                                      ? 'fiat'
                                      : 'lightning');
                              return true;
                            },
                            cardBuilder: (context, index, percentThresholdX, percentThresholdY) => cards[index],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Section 2: Actions
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppTheme.cardPadding.h * 1.75),
                  Text(L10n.of(context)!.actions, style: Theme.of(context).textTheme.titleLarge),
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
                          context.go('/wallet/receive/${controller.selectedCard.value}');
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

          // Section 3: Long Buttons
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: AppTheme.cardPadding),
                Center(
                  child: LongButtonWidget(
                    title: "LOGIN: PLEASE DONT PRESS",
                    onTap: () async {
                      print("Login button pressed");
                      final resultstatus = await startEcsTask('21_inapp_user_dev_tags');
                      print("Result received now: $resultstatus");
                      if (resultstatus == 200){
                        print("Usertask started successfully");
                      } else {
                        print("Some issue occurred (walletscreen).");
                      }
                    },
                  ),
                ),
                SizedBox(height: AppTheme.cardPadding),
                Center(
                  child: LongButtonWidget(
                    title: "REGISTER AND START: DONT PRESS", //PLEASE DON'T PRESS
                    onTap: () async {
                      LoggerService logger = Get.find();
                      final registrationController = Get.find<RegistrationController>();

                      logger.i("Calling Cloudfunction that registers the user now...");

                      // Register user using the RegistrationController
                      registrationController.isLoading.value == true.obs;
                      await registrationController.registerAndSetupUser("walletscreen_testuser_01");

                      if (registrationController.isLoading.value == false.obs) {
                        logger.i("User registered successfully");

                      } else {
                        print("Some issue occurred (walletscreen).");
                      }
                    },
                  ),
                ),
                SizedBox(height: AppTheme.cardPadding),
                Center(
                  child: LongButtonWidget(
                    title: "STOP ECS TASK",
                    onTap: () async {
                      dynamic statusresult = await stopUserTask('23_inapp_user_dev_tags');
                      print("Result received now: ${statusresult.toString()}");
                    },
                  ),
                ),
                SizedBox(height: AppTheme.cardPadding),
                Center(
                  child: LongButtonWidget(
                    title: "CREATE CHALLENGE",
                    onTap: () async {
                      dynamic create_challengeeee = await create_challenge();
                      print("Create challenge response: ${create_challengeeee.toString()}");
                    },
                  ),
                ),
                SizedBox(height: AppTheme.cardPadding),
                Center(
                  child: LongButtonWidget(
                    title: "VERIFY MESSAGE",
                    onTap: () async {
                      dynamic verify_messageeee = await verify_message();
                      print("Verify message response: ${verify_messageeee.toString()}");

                    },
                  ),
                ),
                SizedBox(height: AppTheme.cardPadding),
                Center(
                  child: LongButtonWidget(
                    title: "VERIFY & SIGN & VERIFY",
                    onTap: () async {
                      dynamic userchallenge_rsponse = await create_challenge();
                      print("Create challenge response: ${userchallenge_rsponse.toString()}");


                      //get my key from secure storage
                      PrivateData privateData = await getPrivateData(getUserDidTemp());
                      print("Private mnemonic data: ${privateData.mnemonic.toString()}");
                      print("Private key data: ${privateData.privateKey.toString()}");




                      // dynamic verify_messageeee = await verify_message();
                      // print("Verify message response: ${verify_messageeee.toString()}");

                    },
                  ),
                ),
              ],
            ),
          ),
          // Section 4: Buy/Sell Text and Item
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppTheme.cardPadding.h * 1.75),
                  Text(L10n.of(context)!.buySell, style: Theme.of(context).textTheme.titleLarge),
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
            child: StatefulBuilder(builder: (context, setState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppTheme.cardPadding.h * 1.75),
                    Text(L10n.of(context)!.activity, style: Theme.of(context).textTheme.titleLarge),
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
      ),
    );
  }
}
