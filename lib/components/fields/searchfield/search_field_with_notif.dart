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

  const SearchFieldWithNotificationsWidget({
    Key? key,
    required this.hintText,
    required this.isSearchEnabled,
    // required this.handleSearch,
    this.onChanged, // Initialize it in the constructor
  }) : super(key: key);

  @override
  _SearchFieldWithNotificationsWidgetState createState() =>
      _SearchFieldWithNotificationsWidgetState();
}

class _SearchFieldWithNotificationsWidgetState
    extends State<SearchFieldWithNotificationsWidget> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FeedController>();

    FocusNode _focus = FocusNode();
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppTheme.elementSpacing,
          vertical: AppTheme.elementSpacing),
      child: GlassContainer(
        borderRadius: AppTheme.cardRadiusSmall,
        child: Container(
          height: AppTheme.cardPadding * 2,
          decoration: BoxDecoration(
            borderRadius: AppTheme.cardRadiusSmall,
            boxShadow: [
              AppTheme.boxShadowProfile,
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  enabled: widget.isSearchEnabled,
                  controller: _textFieldController,
                  focusNode: _focus,
                  onFieldSubmitted: (c) {
                    controller.handleSearch(_textFieldController.text, context);
                    _textFieldController.clear();
                  },
                  onChanged: widget.onChanged, // Use the onChanged callback
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(
                        AppTheme.cardPadding / 100,
                      ),
                      hintStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(),
                      hintText: widget.hintText,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppTheme.black60
                            : AppTheme.white70,
                      ),
                      suffixIcon: _textFieldController.text.isEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.paste_outlined,
                              ),
                              onPressed: () async {
                                ClipboardData? clipboardData =
                                    await Clipboard.getData(
                                        Clipboard.kTextPlain);
                                if (clipboardData != null) {
                                  _textFieldController.text =
                                      clipboardData.text!;
                                }
                              },
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.cancel,
                              ),
                              onPressed: () => _textFieldController.clear()),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, style: BorderStyle.none),
                          borderRadius: AppTheme.cardRadiusMid)),
                ),
              ),
              PopupMenuButton<int>(
                color: AppTheme.black80,
                elevation: 2,
                position: PopupMenuPosition.under,
                offset: Offset(0, 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    child: Text("Notification 1"),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: Text("Notification 2"),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("Notification 3"),
                    value: 2,
                  ),
                  PopupMenuDivider(height: 1),
                  PopupMenuItem(
                    child: Text("View All Notification"),
                    value: -1,
                  ),
                ],
                onSelected: (val) {
                  if (val == -1) {
                    context.go('/feed/notification_screen_route');
                  }
                },
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
