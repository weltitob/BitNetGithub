import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

Widget buildSearchField({
  required BuildContext context,
  required dynamic TextFieldController,
  required dynamic handleSearch}) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: AppTheme.elementSpacing,
        vertical: AppTheme.elementSpacing),
    color: Colors.transparent,
    child: Container(
      height: AppTheme.cardPadding * 1.75,
      decoration: BoxDecoration(
        borderRadius: AppTheme.cardRadiusMid,
        boxShadow: [
          AppTheme.boxShadowProfile,
        ],
      ),
      child: TextFormField(
        controller: TextFieldController,
        onFieldSubmitted: handleSearch,
        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(AppTheme.cardPadding / 100),
            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
            ),
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
            suffixIcon: TextFieldController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
              icon: Icon(
                Icons.cancel,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => TextFieldController.clear(),
              color: Theme.of(context).primaryColorDark,
            ),
            fillColor: Theme.of(context).colorScheme.onSecondary,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 0, style: BorderStyle.none),
                borderRadius: AppTheme.cardRadiusMid)),
      ),
    ),
  );
}