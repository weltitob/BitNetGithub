import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/items/amount_previewer.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/currency/bitcoinunitmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsWidget extends StatefulWidget {
  NotificationsWidget({super.key});

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> with AutomaticKeepAliveClientMixin {
  final List<NotificationModel> fakeNotifications = [
    NotificationModel(amount: 500, type: 'sold', date: DateTime(2024, 9, 8)),
    NotificationModel(amount: 700, type: 'sold', date: DateTime(2024, 9, 7)),
    NotificationModel(amount: -500, type: 'bought', date: DateTime(2024, 9, 6)),
    NotificationModel(amount: 200, type: 'sold', date: DateTime(2024, 9, 5)),
    NotificationModel(amount: 300, type: 'sold', date: DateTime(2024, 7, 8)),
    NotificationModel(amount: -500, type: 'bought', date: DateTime(2024, 6, 8)),
    NotificationModel(amount: 100, type: 'sold', date: DateTime(2024, 6, 7)),
    NotificationModel(amount: 200, type: 'sold', date: DateTime(2024, 6, 6)),
    NotificationModel(amount: 500, type: 'offer', date: DateTime(2024, 9, 8)),
    NotificationModel(amount: 1500, type: 'sold', date: DateTime(2024, 5, 8)),
    NotificationModel(amount: 200, type: 'sold', date: DateTime(2024, 5, 7)),
    NotificationModel(amount: 900, type: 'sold', date: DateTime(2024, 5, 6)),
  ];
  bool isLoading = true;
  List<Widget> organizedNotifications = [];
  Map<String, List<SingleNotificationWidget>> categorizedNotifications = {};

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isLoading
        ? SliverToBoxAdapter(child: dotProgress(context))
        : SliverList(delegate: SliverChildBuilderDelegate((ctx, index) {
            if (index == organizedNotifications.length) {
              return SizedBox(height: 80);
            } else if (index == organizedNotifications.length + 1) {
              return null;
            }
            return organizedNotifications[index];
          }));
  }

  Future<void> getNotifications() async {
    //loading
    await Future.delayed(Duration(seconds: 3));
    organizeNotifications();
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void organizeNotifications() {
    categorizedNotifications = {
      'Your Pending Offers': [],
      'This Week': [],
      'Last Week': [],
      'This Month': [],
    };
    fakeNotifications.sort((a, b) => b.date.compareTo(a.date));

    DateTime now = DateTime.now();
    DateTime startOfThisWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime startOfLastWeek = startOfThisWeek.subtract(const Duration(days: 7));
    DateTime startOfThisMonth = DateTime(now.year, now.month, 1);

    for (NotificationModel item in fakeNotifications) {
      DateTime date = item.date;
      if (item.type == 'offer') {
        categorizedNotifications['Your Pending Offers']!.add(SingleNotificationWidget(model: item));
      } else if (date.isAfter(startOfThisMonth)) {
        String timeTag = displayTimeAgoFromInt(item.date.millisecondsSinceEpoch ~/ 1000);
        categorizedNotifications.putIfAbsent(timeTag, () => []).add(SingleNotificationWidget(model: item));
      } else if (date.year == now.year) {
        String monthName = DateFormat('MMMM').format(date);
        String key = monthName;
        categorizedNotifications.putIfAbsent(key, () => []).add(SingleNotificationWidget(model: item));
      } else {
        String yearMonth = '${date.year}, ${DateFormat('MMMM').format(date)}';
        categorizedNotifications.putIfAbsent(yearMonth, () => []).add(SingleNotificationWidget(model: item));
      }
    }
    categorizedNotifications.forEach((category, notifications) {
      if (notifications.isEmpty) return;
      if (category == 'Your Pending Offers') {
        organizedNotifications.add(
          Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding, vertical: AppTheme.elementSpacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  LongButtonWidget(
                      title: 'Cancel',
                      customWidth: AppTheme.cardPadding * 4,
                      customHeight: AppTheme.cardPadding * 1.5,
                      onTap: () {
                        _buildAreYouSureAll(
                            context,
                            notifications.length,
                            NotificationsContainer(
                                notifications: notifications
                                    .map((item) => SingleNotificationWidget(
                                          model: item.model,
                                          showButtons: false,
                                        ))
                                    .toList()));
                      }),
                ],
              ),
            );
          }),
        );
      } else {
        organizedNotifications.add(
          Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding, vertical: AppTheme.elementSpacing),
              child: Text(
                category,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }),
        );
      }

      organizedNotifications.add(NotificationsContainer(notifications: notifications));
    });
  }

  @override
  bool get wantKeepAlive => true;
}

class NotificationModel {
  final String type;
  final double amount;
  final DateTime date;
  const NotificationModel({required this.type, required this.amount, required this.date});
}

class SingleNotificationWidget extends StatelessWidget {
  const SingleNotificationWidget({super.key, required this.model, this.showButtons = true});
  final NotificationModel model;
  final bool showButtons;
  @override
  Widget build(BuildContext context) {
    BitcoinUnitModel unitModel = BitcoinUnitModel(amount: model.amount.toInt(), bitcoinUnit: BitcoinUnits.SAT);
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {},
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppTheme.elementSpacing),
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: AppTheme.elementSpacing * 0.75,
                      right: AppTheme.elementSpacing * 1,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    model.type == 'bought'
                                        ? 'Bought xxxx'
                                        : model.type == 'sold'
                                            ? 'Sold To xxx'
                                            : 'Offer from xxx',
                                    style: Theme.of(context).textTheme.titleLarge),
                                SizedBox(height: AppTheme.elementSpacing),
                                AmountPreviewer(
                                    unitModel: unitModel,
                                    textStyle: Theme.of(context).textTheme.titleLarge!,
                                    textColor: unitModel.amount < 0 ? AppTheme.errorColor : AppTheme.successColor)
                              ],
                            ),
                            Avatar(size: AppTheme.cardPadding * 2, isNft: false)
                          ],
                        ),
                        if (model.type == 'offer' && showButtons) ...[
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              SizedBox(
                                width: AppTheme.cardPadding * 8.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    LongButtonWidget(
                                        title: 'Cancel',
                                        customWidth: AppTheme.cardPadding * 4,
                                        customHeight: AppTheme.cardPadding * 1.5,
                                        onTap: () {
                                          _buildAreYouSureSingle(context, model);
                                        }),
                                    LongButtonWidget(
                                        title: 'Accept',
                                        customWidth: AppTheme.cardPadding * 4,
                                        customHeight: AppTheme.cardPadding * 1.5,
                                        onTap: () {})
                                  ],
                                ),
                              )
                            ],
                          )
                        ]
                      ],
                    )))));
  }
}

class NotificationsContainer extends StatelessWidget {
  const NotificationsContainer({
    super.key,
    required this.notifications,
  });
  final List<SingleNotificationWidget> notifications;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: RepaintBoundary(
        child: GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...notifications.map((item) {
                return item;
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

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
            child: Padding(
              padding: const EdgeInsets.only(top: AppTheme.cardPadding * 2),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: AppTheme.elementSpacing * 4,
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              'Would you really like to cancel this offer worth ${model.amount.toInt().toString()}',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                            Icon(getCurrencyIcon(BitcoinUnits.SAT.name)),
                            Text(
                              'from xxx ?',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: AppTheme.elementSpacing,
                        ),
                        NotificationsContainer(notifications: [
                          SingleNotificationWidget(
                            model: model,
                            showButtons: false,
                          )
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomButtons(
            leftButtonTitle: "Cancel",
            rightButtonTitle: "Confirm",
            onLeftButtonTap: () {
              Navigator.pop(context);
            },
            onRightButtonTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    ),
  );
}

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
            child: Padding(
              padding: const EdgeInsets.only(top: AppTheme.cardPadding * 2),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: AppTheme.elementSpacing * 4,
                          ),
                          Center(
                            child: Text(
                              'Would you really like to cancel all ${amount} pending offers?',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          widget
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BottomButtons(
            leftButtonTitle: "Cancel",
            rightButtonTitle: "Confirm",
            onLeftButtonTap: () {
              Navigator.pop(context);
            },
            onRightButtonTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    ),
  );
}
