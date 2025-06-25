import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:bitnet/pages/profile/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final ProfileController controller;

  @override
  void initState() {
    super.initState();
    // Get or create the ProfileController
    if (Get.isRegistered<ProfileController>()) {
      controller = Get.find<ProfileController>();
    } else {
      controller = Get.put(ProfileController());
    }
    controller.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller.scrollController.position.pixels ==
            controller.scrollController.position.maxScrollExtent &&
        !controller.assetsLoading.value) {
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (controller.assetsLoading.value == false) {
      controller.assetsLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));

      // Call controller method to load more assets
      await controller.loadMoreAssets();

      controller.assetsLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Obx(() {
        // Debug logging
        print('ProfileView - isUserLoading: ${controller.isUserLoading.value}');
        print(
            'ProfileView - profileLoadError: ${controller.profileLoadError.value}');

        if (controller.isUserLoading.value) {
          return Center(child: dotProgress(context));
        }

        // Show error message if profile failed to load
        if (controller.profileLoadError.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.cardPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: AppTheme.elementSpacing * 2),
                  Text(
                    'Profile Error',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppTheme.elementSpacing),
                  Text(
                    controller.profileLoadError.value,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.elementSpacing * 2),
                  LongButtonWidget(
                    buttonType: ButtonType.solid,
                    title: 'Retry',
                    onTap: () {
                      controller.profileLoadError.value = '';
                      controller.isUserLoading.value = true;
                      controller.loadData();
                    },
                  ),
                  const SizedBox(height: AppTheme.elementSpacing),
                  LongButtonWidget(
                    buttonType: ButtonType.transparent,
                    title: 'Log Out',
                    onTap: () async {
                      // Sign out from Firebase
                      await Auth().signOut();
                      // Navigate to auth screen
                      context.go('/authhome');
                    },
                  ),
                ],
              ),
            ),
          );
        }

        return CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            const SliverToBoxAdapter(child: ProfileHeader()),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: AppTheme.cardPadding * 0.5,
              ),
            ),
            Obx(() => controller.pages[controller.currentview.value]),
          ],
        );
      }),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: AppTheme.elementSpacing * 0.75),
          child: LongButtonWidget(
            buttonType: ButtonType.solid,
            customHeight: AppTheme.cardPadding * 1.7,
            customWidth: AppTheme.cardPadding * 4.75,
            leadingIcon: Icon(
              FontAwesomeIcons.add,
              size: AppTheme.cardPadding * 0.75,
              color:
                  Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin
                      ? Colors.white
                      : Theme.of(context).brightness == Brightness.light
                          ? AppTheme.white70
                          : AppTheme.black60,
            ),
            title: 'Create',
            onTap: () {
              context.push('/create');
            },
          ),
        ),
      ),
    );
  }

  // void onQRButtonPressed(BuildContext context) {
  //   BitNetBottomSheet(
  //     width: MediaQuery.sizeOf(context).width,
  //     context: context,
  //     child: bitnetScaffold(
  //       extendBodyBehindAppBar: false,
  //       appBar: bitnetAppBar(
  //         hasBackButton: false,
  //         context: context,
  //         buttonType: ButtonType.transparent,
  //         text: L10n.of(context)!.shareQrCode,
  //       ),
  //       context: context,
  //       body: Center(
  //         child: RepaintBoundary(
  //           key: controller.globalKeyQR,
  //           child: Column(
  //             children: [
  //               const SizedBox(height: AppTheme.cardPadding * 4),
  //               Container(
  //                 margin: const EdgeInsets.all(AppTheme.cardPadding),
  //                 decoration: BoxDecoration(color: Colors.white, borderRadius: AppTheme.cardRadiusSmall),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(AppTheme.elementSpacing),
  //                   child: PrettyQr(
  //                     typeNumber: 5,
  //                     size: AppTheme.cardPadding * 10,
  //                     data: 'did: ${controller.userData.value.did}',
  //                     errorCorrectLevel: QrErrorCorrectLevel.M,
  //                     roundEdges: true,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
