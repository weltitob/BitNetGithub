import 'package:bitnet/pages/auth/restore/userslist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/indicators/smoothpageindicator.dart';
import 'package:bitnet/components/items/userresult.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:lottie/lottie.dart';
import 'package:bitnet/components/loaders/loaders.dart';

class UsersList extends GetView<UsersListController> {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Initialize the controller
    Get.put(UsersListController());

    // controller.onScreenForward();

    return Obx(() {

        if (controller.isLoading.value) {


          return SizedBox(
            height: AppTheme.cardPadding * 8,
            child: Center(child: dotProgress(context)),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppTheme.cardPadding * 0.75),
              child: Container(
                height: AppTheme.cardPadding * 8,
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return SizedBox(
                      height: AppTheme.cardPadding * 8,
                      child: Center(child: dotProgress(context)),
                    );
                  }

                  if (controller.userDataList.isEmpty) {
                    return searchForFilesAnimation(
                        controller.searchForFilesComposition,
                        controller.isVisible.value,
                        context);
                  }

                  if (controller.userDataList.length > 10) {
                    // Show a vertical ScrollView with all users
                    return VerticalFadeListView(
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                        child: SingleChildScrollView(
                          child: Column(
                            children: controller.userDataList.map((userData) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: UserResult(
                                  onTap: () async {
                                    await controller.loginButtonPressed(userData.did);
                                  },
                                  userData: userData,
                                  onDelete: () async {
                                    await controller.deleteUser(userData.did);
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Show the PageView indicator
                    return Column(
                      children: <Widget>[
                        Container(
                          height: AppTheme.cardPadding * 3.5,
                          child: PageView.builder(
                            controller: controller.pageController,
                            onPageChanged: (index) {
                              controller.selectedIndex.value = index;
                            },
                            itemCount: controller.userDataList.length,
                            itemBuilder: (context, index) {
                              final userData = controller.userDataList
                                  .reversed
                                  .toList()[index];
                              var scale = controller.selectedIndex.value == index ? 1.0 : 0.85;

                              return TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: scale, end: scale),
                                curve: Curves.ease,
                                duration: const Duration(milliseconds: 350),
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    child: child,
                                  );
                                },
                                child: Center(
                                  child: UserResult(
                                    onTap: () async {
                                      await controller.loginButtonPressed(userData.did);
                                    },
                                    userData: userData,
                                    onDelete: () async {
                                      await controller.deleteUser(userData.did);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: AppTheme.cardPadding,
                        ),
                        Center(
                          child: CustomIndicator(
                            pageController: controller.pageController,
                            count: controller.userDataList.length,
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
          ],
        );
      }
    );
  }

  /// Widget to display the "search for files" animation
  Widget searchForFilesAnimation(
      Future<LottieComposition> compositionFuture, bool isVisible, BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: AppTheme.cardPadding * 6,
            width: AppTheme.cardPadding * 6,
            child: FutureBuilder<LottieComposition>(
              future: compositionFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: dotProgress(context));
                }
                if (snapshot.hasData) {
                  return FittedBox(
                    fit: BoxFit.fitHeight,
                    child: AnimatedOpacity(
                      opacity: isVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 1000),
                      child: Lottie(composition: snapshot.data!),
                    ),
                  );
                } else {
                  return Container(
                    color: Colors.transparent,
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: AppTheme.elementSpacing,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: AppTheme.cardPadding * 2),
            child: Text(
              "It appears that you haven't added any users to your device yet.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
