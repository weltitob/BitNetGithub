import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget extends StatefulWidget {
  final String hintText;
  final bool isSearchEnabled;
  final dynamic handleSearch;
  final dynamic onChanged; // Add an onChanged callback
  final dynamic suffixIcon;
  final Function(TextEditingController)? onSuffixTap;
  final FocusNode? node;

  const SearchFieldWidget({
    Key? key,
    required this.hintText,
    required this.isSearchEnabled,
    required this.handleSearch,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged,
    this.node, // Initialize it in the constructor
  }) : super(key: key);

  @override
  _SearchFieldWidgetState createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GlassContainer(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
        child: Container(
          height: AppTheme.cardPadding * 1.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
          ),
          child: TextFormField(
            enabled: widget.isSearchEnabled,
            controller: _textFieldController,
            onFieldSubmitted: widget.handleSearch,
            focusNode: widget.node,
            onChanged: (value) {
              setState(() {
                _textFieldController.text = value; // Update the controller text
              });
              widget.onChanged?.call(value); // Trigger the onChanged callback
            },
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.all(AppTheme.cardPadding / 100),
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                hintText: widget.hintText,
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppTheme.black60
                      : AppTheme.white70,
                ),
                suffixIcon: _textFieldController.text.isEmpty ||
                        _textFieldController.text == ''
                    ? widget.suffixIcon != null
                        ? widget.suffixIcon
                        : const SizedBox.shrink()
                    : IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppTheme.black60
                                  : AppTheme.white70,
                        ),
                        onPressed: () {
                          if (widget.onSuffixTap != null) {
                            widget.onSuffixTap!(_textFieldController);
                          } else {
                            _textFieldController.clear();
                          }
                        },
                      ),
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                    borderRadius:
                        BorderRadius.circular(AppTheme.borderRadiusMid))),
          ),
        ),
      ),
    );
  }
}
