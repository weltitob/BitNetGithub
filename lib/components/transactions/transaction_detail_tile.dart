import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

class TransactionDetailTile extends StatelessWidget {
  final String text;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  
  const TransactionDetailTile({
    required this.text,
    this.trailing,
    this.leading,
    this.onTap,
    this.contentPadding,
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding ?? const EdgeInsets.symmetric(
        horizontal: AppTheme.elementSpacing * 0.75,
        vertical: AppTheme.elementSpacing * 0.5,
      ),
      onTap: onTap,
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: trailing,
      leading: leading,
    );
  }
}