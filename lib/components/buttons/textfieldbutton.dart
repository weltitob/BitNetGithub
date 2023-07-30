import 'package:BitNet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

class TextFieldButton extends StatelessWidget {
  final IconData iconData;
  final Function() onTap;

  const TextFieldButton({Key? key, required this.iconData, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: AppTheme.cardRadiusBig,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            iconData,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}

class TextFieldButtonMorph extends StatelessWidget {
  final IconData iconData;
  final Function() onTap;

  const TextFieldButtonMorph({
    Key? key,
    required this.iconData,
    required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.glassMorphColor,
          borderRadius: AppTheme.cardRadiusBig,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            iconData,
            color: AppTheme.white90,
          ),
        ),
      ),
    );
  }
}
