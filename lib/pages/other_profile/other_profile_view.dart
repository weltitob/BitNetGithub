import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/pages/other_profile/other_profile_controller.dart';
import 'package:bitnet/pages/other_profile/widgets/other_profile_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class OtherProfileView extends StatefulWidget {
  final String profileId;
  const OtherProfileView({Key? key, required this.profileId}) : super(key: key);

  @override
  _OtherProfileViewState createState() => _OtherProfileViewState();
}

class _OtherProfileViewState extends State<OtherProfileView> {
  late final OtherProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(OtherProfileController(profileId: widget.profileId));
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
    return Obx(
      () => bitnetScaffold(
          context: context,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          extendBodyBehindAppBar: true,
          appBar: bitnetAppBar(
            context: context,
            onTap: () {
              try {
                context.pop();
              } catch (e) {
                if (Auth().currentUser != null) {
                  context.go('/feed');
                } else {
                  context.go('/authhome');
                }
              }
            },
          ),
          body: PopScope(
            canPop: false,
            onPopInvoked: (b) {
              try {
                context.pop();
              } catch (e) {
                if (Auth().currentUser != null) {
                  context.go('/feed');
                } else {
                  context.go('/authhome');
                }
              }
            },
            child: controller.isUserLoading.value
                ? Center(child: dotProgress(context))
                : CustomScrollView(
                    controller: controller.scrollController,
                    slivers: [
                      const SliverToBoxAdapter(
                          child: const OtherProfileHeader()),
                      const SliverToBoxAdapter(
                        child: const SizedBox(
                          height: AppTheme.cardPadding * 0.75,
                        ),
                      ),
                      Obx(() {
                        return controller.pages[controller.currentview.value];
                      }),
                    ],
                  ),
          )),
    );
  }
}
