import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/dividers/dividerwithtext.dart';
import 'package:flutter/material.dart';

class SearchTitle extends StatelessWidget {
  final String title;
  final Widget icon;
  final Widget? trailing;
  final void Function()? onTap;
  final Color? color;

  const SearchTitle({
    required this.title,
    required this.icon,
    this.trailing,
    this.onTap,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return DividerWithText(
     child: Material(
       borderRadius: AppTheme.cardRadiusBig,
       color: color ?? Theme.of(context).colorScheme.background,
       child: InkWell(
         onTap: onTap,
         splashColor: Theme.of(context).colorScheme.surface,
         child: Align(
           alignment: Alignment.centerLeft,
           child: Padding(
             padding: const EdgeInsets.symmetric(
               horizontal: AppTheme.cardPadding / 2,
               vertical: AppTheme.elementSpacing * 1.5,
             ),
             child: IconTheme(
               data: Theme.of(context).iconTheme.copyWith(size: AppTheme.cardPadding),
               child: Row(
                 children: [
                   icon,
                   const SizedBox(width: AppTheme.elementSpacing),
                   Text(
                       title,
                       textAlign: TextAlign.left,
                       style: Theme.of(context).textTheme.labelLarge
                   ),
                   if (trailing != null)
                     Expanded(
                       child: Align(
                         alignment: Alignment.centerRight,
                         child: trailing!,
                       ),
                     ),
                 ],
               ),
             ),
           ),
         ),
       ),
     ),
   );
  }
}
