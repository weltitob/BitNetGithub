import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
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
    controller.selectedIndex.value = 0;
    // One Obx at the top to watch isLoading, userDataList, etc.
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
            child: SizedBox(
              height: AppTheme.cardPadding * 8,
              child: _buildUsers(context),
            ),
          ),
        ],
      );
    });
  }

  /// Builds the main content for the list or page view
  Widget _buildUsers(BuildContext context) {
    // If still loading
    if (controller.isLoading.value) {
      return SizedBox(
        height: AppTheme.cardPadding * 8,
        child: Center(child: dotProgress(context)),
      );
    }

    // If no users are found
    if (controller.userDataList.isEmpty) {
      return searchForFilesAnimation(
        controller.searchForFilesComposition,
        controller.isVisible.value,
        context,
      );
    }

    // If more than 10 users, show vertical list
    if (controller.userDataList.length > 10) {
      return VerticalFadeListView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: SingleChildScrollView(
            child: Column(
              children: controller.userDataList.map((userData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: UserResult(
                    onTap: () async {
                      await controller.loginButtonPressed(
                        userData.did,
                        context,
                      );
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
    }

    // Show a PageView with an indicator
    return Column(
      children: [
        SizedBox(
          height: AppTheme.cardPadding * 3.5,
          child: PageView.builder(
            controller: controller.pageController,
            onPageChanged: (index) {
              // Update the selectedIndex
              controller.selectedIndex.value = index;
            },
            itemCount: controller.userDataList.length,
            itemBuilder: (context, index) {
              // Build each item in its own Obx => forces re-check of selectedIndex
              return Obx(() {
                final isSelected = (controller.selectedIndex.value == index);
                final userData = controller.userDataList[index];

                return Center(
                  child: AnimatedScale(
                    scale: isSelected ? 1.0 : 0.85,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    child: UserResult(
                      onTap: () async {
                        await controller.loginButtonPressed(
                          userData.did,
                          context,
                        );
                      },
                      userData: userData,
                      onDelete: () async {
                        await controller.deleteUser(userData.did);
                      },
                    ),
                  ),
                );
              });
            },
          ),
        ),
        const SizedBox(height: AppTheme.cardPadding),
        Center(
          child: CustomIndicator(
            pageController: controller.pageController,
            count: controller.userDataList.length,
          ),
        ),
      ],
    );
  }

  /// Widget to display the "search for files" animation
  Widget searchForFilesAnimation(
      Future<LottieComposition> compositionFuture,
      bool isVisible,
      BuildContext context,
      ) {
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
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          const SizedBox(height: AppTheme.elementSpacing),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppTheme.cardPadding * 2,
            ),
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
