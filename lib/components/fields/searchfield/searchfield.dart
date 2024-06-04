import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget extends StatefulWidget {
  final String hintText;
  final bool isSearchEnabled;
  final dynamic handleSearch;
  final dynamic onChanged; // Add an onChanged callback
  final dynamic suffixIcon;
  final dynamic onSuffixTap;

  const SearchFieldWidget({
    Key? key,
    required this.hintText,
    required this.isSearchEnabled,
    required this.handleSearch,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged, // Initialize it in the constructor
  }) : super(key: key);

  @override
  _SearchFieldWidgetState createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: AppTheme.elementSpacing,
          vertical: AppTheme.elementSpacing),
      child: GlassContainer(
        borderRadius: AppTheme.cardRadiusSmall,
        child: Container(
          height: AppTheme.cardPadding * 1.75,
          decoration: BoxDecoration(
            borderRadius: AppTheme.cardRadiusSmall,
            boxShadow: [
              AppTheme.boxShadowProfile,
            ],
          ),
          child: TextFormField(
            enabled: widget.isSearchEnabled,
            controller: _textFieldController,
            onFieldSubmitted: widget.handleSearch,
            onChanged: widget.onChanged, // Use the onChanged callback
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(AppTheme.cardPadding / 100),
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                hintText: widget.hintText,
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppTheme.black60
                      : AppTheme.white70,
                ),
                suffixIcon: widget.suffixIcon != null
                    ? widget.suffixIcon
                    : _textFieldController.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            icon: Icon(
                              Icons.cancel,
                            ),
                            onPressed: () =>
                                widget.onSuffixTap ??
                                _textFieldController.clear(),
                          ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    borderRadius: AppTheme.cardRadiusMid)),
          ),
        ),
      ),
    );
  }
}
