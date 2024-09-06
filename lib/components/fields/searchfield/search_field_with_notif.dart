import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/pages/feed/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SearchFieldWithNotificationsWidget extends StatefulWidget {
  final String hintText;
  final bool isSearchEnabled;
  // final dynamic handleSearch;
  final dynamic onChanged; // Add an onChanged callback
  final FocusNode focus;
  const SearchFieldWithNotificationsWidget({
    Key? key,
    required this.hintText,
    required this.isSearchEnabled,
    // required this.handleSearch,
    this.onChanged,
    required this.focus, // Initialize it in the constructor
  }) : super(key: key);

  @override
  _SearchFieldWithNotificationsWidgetState createState() => _SearchFieldWithNotificationsWidgetState();
}

class _SearchFieldWithNotificationsWidgetState extends State<SearchFieldWithNotificationsWidget> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing, vertical: AppTheme.elementSpacing),
      child: GlassContainer(
        customColor:Theme.of(context).brightness == Brightness.light ? Colors.grey.withAlpha(50) : null,
        borderRadius: AppTheme.cardRadiusSmall,
        child: Container(
          height: AppTheme.cardPadding * 2,
          decoration: BoxDecoration(
            borderRadius: AppTheme.cardRadiusSmall,
            boxShadow: Theme.of(context).brightness == Brightness.light ? [
            ] : [
              AppTheme.boxShadowProfile
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  enabled: widget.isSearchEnabled,
                  focusNode: widget.focus,
                  controller: _textFieldController,
                  onFieldSubmitted: (c) {
                    widget.focus.unfocus();
                    controller.handleSearch(_textFieldController.text, context);
                    _textFieldController.clear();
                  },
                  onChanged: widget.onChanged, // Use the onChanged callback
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(
                        AppTheme.cardPadding / 100,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodySmall,
                      hintText: widget.hintText,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).brightness == Brightness.light ? null : AppTheme.white70,
                      ),
                      suffixIcon: _textFieldController.text.isEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.paste_outlined,
                              ),
                              onPressed: () async {
                                ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
                                if (clipboardData != null) {
                                  _textFieldController.text = clipboardData.text!;
                                }
                              },
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.cancel,
                              ),
                              onPressed: () => _textFieldController.clear()),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0, style: BorderStyle.none), borderRadius: AppTheme.cardRadiusMid)),
                ),
              ),
              PopupMenuButton<int>(
                color: Theme.of(context).brightness == Brightness.light ? AppTheme.white80 : AppTheme.black80,
                elevation: 2,
                position: PopupMenuPosition.under,
                offset: const Offset(0, 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    child: Text("Notification 1"),
                    value: 0,
                  ),
                  const PopupMenuItem(
                    child: Text("Notification 2"),
                    value: 1,
                  ),
                  const PopupMenuItem(
                    child: Text("Notification 3"),
                    value: 2,
                  ),
                  const PopupMenuDivider(height: 1),
                  const PopupMenuItem(
                    child: Text("View All Notification"),
                    value: -1,
                  ),
                ],
                onSelected: (val) {
                  if (val == -1) {
                    context.go('/feed/notification_screen_route');
                  }
                },
                icon: const Icon(
                  Icons.notifications_none_outlined,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
