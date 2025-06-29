import 'package:animate_do/animate_do.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/timezone_provider.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:bitnet/pages/secondpages/mempool/widget/data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';

/// Horizontal scrollable list view that displays both mempool blocks
/// and confirmed blocks
class BlocksListView extends StatelessWidget {
  final ScrollController scrollController;
  final Function(int) onMempoolBlockTap;
  final Function(int) onConfirmedBlockTap;
  final bool isLoading;
  final Function(String) hasUserTxs;

  const BlocksListView({
    Key? key,
    required this.scrollController,
    required this.onMempoolBlockTap,
    required this.onConfirmedBlockTap,
    required this.isLoading,
    required this.hasUserTxs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    Location loc =
        Provider.of<TimezoneProvider>(context, listen: false).timeZone;

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        SingleChildScrollView(
          primary: false,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              // Mempool blocks section
              _buildMempoolBlocks(context, controller),

              // Divider between sections
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppTheme.elementSpacing,
                ),
                decoration: BoxDecoration(
                  borderRadius: AppTheme.cardRadiusCircular,
                  color: Colors.grey,
                ),
                height: AppTheme.cardPadding * 6,
                width: AppTheme.elementSpacing / 3,
              ),

              // Confirmed blocks section
              _buildConfirmedBlocks(context, controller, loc),
            ],
          ),
        ),

        // Back button for blockHeight navigation
        _buildBackButton(controller),
      ],
    );
  }

  Widget _buildMempoolBlocks(BuildContext context, HomeController controller) {
    return Obx(
      () {
        return controller.isLoading.isTrue
            ? dotProgress(context)
            : controller.mempoolBlocks.isEmpty
                ? const Text(
                    'Something went wrong!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  )
                : SizedBox(
                    height: 255,
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.mempoolBlocks.length,
                      itemBuilder: (context, index) {
                        var min =
                            (index + 1) * (controller.da!.timeAvg! / 60000);
                        return GestureDetector(
                          onTap: () => onMempoolBlockTap(index),
                          child: Flash(
                            infinite: true,
                            delay: const Duration(seconds: 10),
                            duration: const Duration(seconds: 5),
                            child: DataWidget.notAccepted(
                                key: index == 0
                                    ? controller.containerKey
                                    : GlobalKey(),
                                mempoolBlocks: controller.mempoolBlocks[index],
                                mins: min.toStringAsFixed(0),
                                index: controller.selectedIndexData == index
                                    ? 1
                                    : 0,
                                singleTx: false,
                                hasUserTxs: false),
                          ),
                        );
                      },
                    ),
                  );
      },
    );
  }

  Widget _buildConfirmedBlocks(
      BuildContext context, HomeController controller, Location loc) {
    return Obx(
      () {
        return controller.isLoading.isTrue
            ? dotProgress(context)
            : controller.bitcoinData.isEmpty
                ? const Text(
                    'Something went wrong!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  )
                : GetBuilder<HomeController>(builder: (controller) {
                    return SizedBox(
                      height: 255,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.bitcoinData.length,
                        itemBuilder: (context, index) {
                          double size =
                              controller.bitcoinData[index].size! / 1000000;

                          return GestureDetector(
                            onTap: () => onConfirmedBlockTap(index),
                            child: DataWidget.accepted(
                              blockData: controller.bitcoinData[index],
                              txId: controller.bitcoinData[index].id,
                              size: size,
                              time: controller.formatTimeAgo(
                                DateTime.fromMillisecondsSinceEpoch(
                                  (controller.bitcoinData[index].timestamp! *
                                      1000),
                                ).toUtc().add(Duration(
                                    milliseconds: loc.currentTimeZone.offset)),
                              ),
                              index: controller.selectedIndex == index ? 1 : 0,
                              singleTx: false,
                              hasUserTxs:
                                  hasUserTxs(controller.bitcoinData[index].id!),
                            ),
                          );
                        },
                      ),
                    );
                  });
      },
    );
  }

  Widget _buildBackButton(HomeController controller) {
    return controller.blockHeight != null
        ? Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              onTap: () async {
                controller.bitcoinData.clear();
                await controller.getData();
                controller.showBlock.value = true;
                controller.showNextBlock.value = false;
                controller.indexBlock.value = 0;
                controller.selectedIndex = 0;
                controller.selectedIndexData = -1;

                await controller
                    .txDetailsConfirmedF(controller.bitcoinData.first.id!);
                await controller.txDetailsF(
                    controller.bitcoinData.first.id!, 0);

                scrollController.animateTo(controller.scrollValue.value.w,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut);

                controller.blockHeight = null;
              },
              child: Opacity(
                opacity: 0.75,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppTheme.white60,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppTheme.colorBackground,
                  ),
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
