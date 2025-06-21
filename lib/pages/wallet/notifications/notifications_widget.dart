import 'dart:ui';

import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/glasscontainerborder.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/items/amount_previewer.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



/// A top-level helper to color-code each notification type
Color _getTypeColor(String type) {
  switch (type) {
    case 'bought':
      return AppTheme.errorColor;    // red for money spent
    case 'sold':
      return AppTheme.successColor;  // green for money received
    case 'offer':
      return AppTheme.colorBitcoin;  // bitcoin orange for offers
    default:
      return Colors.grey;            // fallback
  }
}

/// A top-level helper to choose an icon based on notification type
IconData _getTypeIcon(String type) {
  switch (type) {
    case 'bought':
      return Icons.shopping_cart;
    case 'sold':
      return Icons.sell;
    case 'offer':
      return Icons.local_offer;
    default:
      return Icons.notifications;
  }
}

/// A top-level helper to build the main title text for each notification
String _buildNotificationTitle(String type) {
  switch (type) {
    case 'bought':
      return 'Bought from @username';
    case 'sold':
      return 'Sold to @username';
    case 'offer':
      return 'New offer from @username';
    default:
      return 'Transaction';
  }
}

/// Model class for your notifications
class NotificationModel {
  final String type;
  final double amount;
  final DateTime date;
  const NotificationModel({
    required this.type,
    required this.amount,
    required this.date,
  });
}

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> with AutomaticKeepAliveClientMixin {
  final List<NotificationModel> fakeNotifications = [
    NotificationModel(amount: 500,  type: 'sold',   date: DateTime(2024, 9, 8)),
    NotificationModel(amount: 700,  type: 'sold',   date: DateTime(2024, 9, 7)),
    NotificationModel(amount: -500, type: 'bought', date: DateTime(2024, 9, 6)),
    NotificationModel(amount: 200,  type: 'sold',   date: DateTime(2024, 9, 5)),
    NotificationModel(amount: 300,  type: 'sold',   date: DateTime(2024, 7, 8)),
    NotificationModel(amount: -500, type: 'bought', date: DateTime(2024, 6, 8)),
    NotificationModel(amount: 100,  type: 'sold',   date: DateTime(2024, 6, 7)),
    NotificationModel(amount: 200,  type: 'sold',   date: DateTime(2024, 6, 6)),
    NotificationModel(amount: 500,  type: 'offer',  date: DateTime(2024, 9, 8)),
    NotificationModel(amount: 1500, type: 'sold',   date: DateTime(2024, 5, 8)),
    NotificationModel(amount: 200,  type: 'sold',   date: DateTime(2024, 5, 7)),
    NotificationModel(amount: 900,  type: 'sold',   date: DateTime(2024, 5, 6)),
  ];

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProfileController controller = Get.find<ProfileController>();
    return controller.isLoadingNotifs
        ? SliverToBoxAdapter(child: dotProgress(context))
        : SliverList(
      delegate: SliverChildBuilderDelegate(
            (ctx, index) {
          // Add some spacing at the bottom
          if (index == controller.organizedNotifications.length) {
            return const SizedBox(height: 80);
          } else if (index == controller.organizedNotifications.length + 1) {
            return null;
          }
          return controller.organizedNotifications[index];
        },
        childCount: controller.organizedNotifications.length + 2,
      ),
    );
  }

  Future<void> getNotifications() async {
    final ProfileController controller = Get.find<ProfileController>();
    // Simulate loading
    await Future.delayed(const Duration(seconds: 3));
    organizeNotifications();
    controller.isLoadingNotifs = false;
    if (mounted) {
      setState(() {});
    }
  }

  void organizeNotifications() {
    final ProfileController controller = Get.find<ProfileController>();

    // Initialize or clear the categorized map
    controller.categorizedNotifications = {
      'Your Pending Offers': [],
      'This Week': [],
      'Last Week': [],
      'This Month': [],
    };

    // Sort notifications by most recent date
    fakeNotifications.sort((a, b) => b.date.compareTo(a.date));

    DateTime now = DateTime.now();
    DateTime startOfThisMonth = DateTime(now.year, now.month, 1);

    for (NotificationModel item in fakeNotifications) {
      DateTime date = item.date;
      if (item.type == 'offer') {
        controller.categorizedNotifications['Your Pending Offers']!
            .add(SingleNotificationWidget(model: item));
      } else if (date.isAfter(startOfThisMonth)) {
        // If it's after the start of this month, display time-ago or date
        String timeTag =
        displayTimeAgoFromInt(item.date.millisecondsSinceEpoch ~/ 1000);
        controller.categorizedNotifications
            .putIfAbsent(timeTag, () => [])
            .add(SingleNotificationWidget(model: item));
      } else if (date.year == now.year) {
        // Group by month name
        String monthName = DateFormat('MMMM').format(date);
        controller.categorizedNotifications
            .putIfAbsent(monthName, () => [])
            .add(SingleNotificationWidget(model: item));
      } else {
        // Group by Year + Month
        String yearMonth =
            '${date.year}, ${DateFormat('MMMM').format(date)}';
        controller.categorizedNotifications
            .putIfAbsent(yearMonth, () => [])
            .add(SingleNotificationWidget(model: item));
      }
    }

    // Build the final list of widgets in organizedNotifications
    controller.organizedNotifications.clear();

    controller.categorizedNotifications.forEach((category, notifications) {
      if (notifications.isEmpty) return;

      // Section heading
      if (category == 'Your Pending Offers') {
        // Special heading for “Your Pending Offers” with a Cancel-all button
        controller.organizedNotifications.add(
          Builder(
            builder: (context) {
              return Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding.w,
                  vertical: AppTheme.elementSpacing.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      category,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    LongButtonWidget(
                      title: 'Cancel All',
                      buttonType: ButtonType.transparent,
                      customWidth: 100.w,
                      customHeight: 32.h,
                      titleStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.errorColor,
                        fontWeight: FontWeight.w500,
                      ),
                      onTap: () {
                        _buildAreYouSureAll(
                          context,
                          notifications.length,
                          NotificationsContainer(
                            notifications: notifications
                                .map(
                                  (item) => SingleNotificationWidget(
                                model: item.model,
                                showButtons: false,
                              ),
                            )
                                .toList(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      } else {
        // Standard heading
        controller.organizedNotifications.add(
          Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding,
                  vertical: AppTheme.elementSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppTheme.elementSpacing),
                    Text(
                      category,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Optional divider for a cleaner look:
                    // const Divider(),
                  ],
                ),
              );
            },
          ),
        );
      }

      // Add the container of notifications
      controller.organizedNotifications
          .add(NotificationsContainer(notifications: notifications));
    });
  }

  @override
  bool get wantKeepAlive => true;
}

/// Single notification card with improved UI
class SingleNotificationWidget extends StatelessWidget {
  const SingleNotificationWidget({
    Key? key,
    required this.model,
    this.showButtons = true,
  }) : super(key: key);

  final NotificationModel model;
  final bool showButtons;

  @override
  Widget build(BuildContext context) {
    final color = _getTypeColor(model.type);
    final icon = _getTypeIcon(model.type);

    // Use absolute value for display, sign is shown by color
    final BitcoinUnitModel unitModel = BitcoinUnitModel(
      amount: model.amount.abs().toInt(),
      bitcoinUnit: BitcoinUnits.SAT,
    );

    return InkWell(
      onTap: () {
        // handle tapping on a single notification
      },
      borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.cardPaddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top row: icon + text (title/date) + trailing amount
            Row(
              children: [
                // Leading icon in a modern container
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20.w,
                  ),
                ),
                SizedBox(width: AppTheme.elementSpacing),
                // Title & date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _buildNotificationTitle(model.type),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        displayTimeAgoFromInt(model.date.millisecondsSinceEpoch ~/ 1000),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                      ),
                    ],
                  ),
                ),
                // Trailing amount with proper formatting
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (model.amount < 0)
                          Text(
                            '- ',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.errorColor,
                            ),
                          )
                        else if (model.amount > 0)
                          Text(
                            '+ ',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.successColor,
                            ),
                          ),
                        AmountPreviewer(
                          unitModel: unitModel,
                          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ) ?? TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textColor: model.amount < 0
                              ? AppTheme.errorColor
                              : model.amount > 0
                                  ? AppTheme.successColor
                                  : Theme.of(context).colorScheme.onSurface,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            /// If it's an offer, show Accept/Cancel buttons
            if (model.type == 'offer' && showButtons) ...[
              const SizedBox(height: AppTheme.elementSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LongButtonWidget(
                    buttonType: ButtonType.transparent,
                    title: 'Decline',
                    customWidth: 90.w,
                    customHeight: 36.h,
                    titleStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    onTap: () => _buildAreYouSureSingle(context, model),
                  ),
                  SizedBox(width: AppTheme.elementSpacing.w),
                  LongButtonWidget(
                    buttonType: ButtonType.solid,
                    title: 'Accept',
                    customWidth: 90.w,
                    customHeight: 36.h,
                    onTap: () {
                      // handle accept
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Container for a group of notifications
class NotificationsContainer extends StatelessWidget {
  const NotificationsContainer({
    Key? key,
    required this.notifications,
  }) : super(key: key);

  final List<SingleNotificationWidget> notifications;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: GlassContainer(
        customShadow: Theme.of(context).brightness == Brightness.dark ? [] : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMid - 1),
          child: Column(
            children: [
              for (int i = 0; i < notifications.length; i++) ...[
                notifications[i],
                if (i < notifications.length - 1)
                  Divider(
                    height: 1,
                    thickness: 1,
                    indent: AppTheme.cardPaddingSmall,
                    endIndent: AppTheme.cardPaddingSmall,
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom sheet confirmation for a single offer
_buildAreYouSureSingle(BuildContext context, NotificationModel model) {
  return BitNetBottomSheet(
    context: context,
    child: bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        hasBackButton: false,
        context: context,
        text: "Are you sure?",
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: AppTheme.cardPadding * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      'Would you really like to cancel this offer worth '
                          '${model.amount.toInt()} ',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    Icon(getCurrencyIcon(BitcoinUnits.SAT.name)),
                    Text(
                      ' from xxx?',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.elementSpacing),
                NotificationsContainer(
                  notifications: [
                    SingleNotificationWidget(
                      model: model,
                      showButtons: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
          BottomButtons(
            leftButtonTitle: "Cancel",
            rightButtonTitle: "Confirm",
            onLeftButtonTap: () => Navigator.pop(context),
            onRightButtonTap: () {
              // handle confirm
              Navigator.pop(context);
            },
          )
        ],
      ),
    ),
  );
}

/// Bottom sheet confirmation for multiple offers
_buildAreYouSureAll(BuildContext context, int amount, NotificationsContainer widget) {
  return BitNetBottomSheet(
    context: context,
    child: bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        hasBackButton: false,
        context: context,
        text: "Are you sure?",
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: AppTheme.cardPadding * 2),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Would you really like to cancel all $amount pending offers?',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppTheme.elementSpacing),
                  widget,
                ],
              ),
            ),
          ),
          BottomButtons(
            leftButtonTitle: "Cancel",
            rightButtonTitle: "Confirm",
            onLeftButtonTap: () => Navigator.pop(context),
            onRightButtonTap: () {
              // handle confirm
              Navigator.pop(context);
            },
          )
        ],
      ),
    ),
  );
}
