import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

class SearchFieldWithNotificationsWidget extends StatefulWidget {
  final String hintText;
  final bool isSearchEnabled;
  final dynamic onChanged;
  final FocusNode focus;
  final int notificationCount;

  const SearchFieldWithNotificationsWidget({
    Key? key,
    required this.hintText,
    required this.isSearchEnabled,
    this.onChanged,
    required this.focus,
    this.notificationCount = 0,
  }) : super(key: key);

  @override
  _SearchFieldWithNotificationsWidgetState createState() => _SearchFieldWithNotificationsWidgetState();
}

class _SearchFieldWithNotificationsWidgetState extends State<SearchFieldWithNotificationsWidget> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final backgroundColor = isDarkMode ? AppTheme.black60 : Colors.grey.withAlpha(30);
    final iconColor = isDarkMode ? AppTheme.white70 : primaryColor.withOpacity(0.7);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing, vertical: AppTheme.elementSpacing),
      child: GlassContainer(

        borderRadius: AppTheme.cardRadiusSmall,
        child: Container(
          height: AppTheme.cardPadding * 2,
          decoration: BoxDecoration(
            borderRadius: AppTheme.cardRadiusSmall,
            boxShadow: isDarkMode ? [AppTheme.boxShadowProfile] : [],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  enabled: widget.isSearchEnabled,
                  focusNode: widget.focus,
                  controller: _textFieldController,
                  onFieldSubmitted: (text) {
                    widget.focus.unfocus();
                    controller.handleSearch(_textFieldController.text, context);
                    _textFieldController.clear();
                  },
                  onChanged: widget.onChanged,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(AppTheme.cardPadding / 100),
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    hintText: widget.hintText,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: iconColor,
                      size: 22,
                    ),
                    suffixIcon: _textFieldController.text.isEmpty
                        ? _buildClipboardButton(iconColor)
                        : _buildClearButton(iconColor),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0, style: BorderStyle.none), 
                      borderRadius: AppTheme.cardRadiusMid
                    ),
                  ),
                ),
              ),
              _buildNotificationButton(primaryColor, iconColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClipboardButton(Color iconColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
            if (clipboardData != null && clipboardData.text != null) {
              setState(() {
                _textFieldController.text = clipboardData.text!;
                if (widget.onChanged != null) {
                  widget.onChanged(_textFieldController.text);
                }
              });
            }
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.content_paste_rounded,
                color: iconColor,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton(Color iconColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            setState(() {
              _textFieldController.clear();
              if (widget.onChanged != null) {
                widget.onChanged('');
              }
            });
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.close_rounded,
                color: iconColor,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationButton(Color primaryColor, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: badges.Badge(
        showBadge: widget.notificationCount > 0,
        badgeContent: Text(
          widget.notificationCount > 9 ? '9+' : widget.notificationCount.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        badgeStyle: badges.BadgeStyle(
          badgeColor: primaryColor,
          padding: const EdgeInsets.all(5),
        ),
        position: badges.BadgePosition.topEnd(top: -5, end: -3),
        child: Material(
          color: Colors.transparent,
          child: PopupMenuButton<int>(
            color: Theme.of(context).brightness == Brightness.light 
                ? AppTheme.white80 
                : AppTheme.black80,
            elevation: 3,
            position: PopupMenuPosition.under,
            offset: const Offset(0, 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            itemBuilder: (BuildContext context) => [
              _buildNotificationItem("New message from user", "2 min ago", Icons.message_rounded, 0),
              _buildNotificationItem("Transaction completed", "15 min ago", Icons.check_circle_outline_rounded, 1),
              _buildNotificationItem("New feature available", "1 hour ago", Icons.new_releases_outlined, 2),
              const PopupMenuDivider(height: 1),
              const PopupMenuItem(
                value: -1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View All Notifications",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (val) {
              if (val == -1) {
                context.go('/feed/notification_screen_route');
              }
            },
            icon: Icon(
              Icons.notifications_outlined,
              color: iconColor,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<int> _buildNotificationItem(String title, String time, IconData icon, int value) {
    return PopupMenuItem(
      value: value,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3.0, right: 10.0),
            child: Icon(
              icon,
              size: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}