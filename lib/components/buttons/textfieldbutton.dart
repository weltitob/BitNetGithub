import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:flutter/material.dart';

class TextFieldButton extends StatelessWidget {
  final IconData iconData;
  final Function() onTap;

  const TextFieldButton({Key? key, required this.iconData, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: AppTheme.cardRadiusBig,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              iconData,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldButtonMorph extends StatelessWidget {
  final IconData iconData;
  final Function() onTap;

  const TextFieldButtonMorph({Key? key, required this.iconData, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            iconData,
            color: Theme.of(context).brightness == Brightness.light ? AppTheme.black90 : AppTheme.white90,
          ),
        ),
      ),
    );
  }
}
