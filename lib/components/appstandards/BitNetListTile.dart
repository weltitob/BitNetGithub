import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';

class BitNetListTile extends StatelessWidget {
  final Widget? leading;
  final String text;
  final Widget? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry contentPadding;
  final Function()? onTap;
  final Color? tileColor;
  final ShapeBorder? shape;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const BitNetListTile({
    super.key,
    this.leading,
    this.text = "",
    this.subtitle,
    this.trailing,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.onTap,
    this.tileColor,
    this.shape,
    this.titleStyle,
    this.subtitleStyle,
  });

  //Inkwell funktioniert hier noch nicht
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppTheme.elementSpacing),
      child: LongButtonWidget(
        customHeight: AppTheme.cardPadding * 2,
        customWidth: MediaQuery.of(context).size.width - AppTheme.cardPadding,
        title: text,
        buttonType: ButtonType.transparent,
        leadingIcon: leading,
        onTap: () {  },

      ),
    );

    //
    //   InkWell(
    //   onTap: onTap,
    //   borderRadius: BorderRadius.circular(AppTheme.cardPadding * 2 / 2.5),
    //   child: Padding(
    //     padding: const EdgeInsets.only(bottom: AppTheme.elementSpacing),
    //     child: GlassContainer(
    //       height: AppTheme.cardPadding * 2,
    //       width: MediaQuery.of(context).size.width - AppTheme.cardPadding ,
    //       borderThickness: 1.5, // remove border if not active
    //       blur: 50,
    //       opacity: 0.1,
    //       borderRadius:
    //       BorderRadius.circular(AppTheme.cardPadding * 2 / 2.5),
    //       child: ListTile(
    //         leading: leading,
    //         title: title != null ? DefaultTextStyle(style: titleStyle ?? Theme.of(context).textTheme.subtitle1!, child: title!) : null,
    //         subtitle: subtitle != null ? DefaultTextStyle(style: subtitleStyle ?? Theme.of(context).textTheme.bodyText2!, child: subtitle!) : null,
    //         trailing: trailing,
    //         contentPadding: contentPadding,
    //         onTap: onTap,
    //         tileColor: tileColor,
    //         shape: shape,
    //       ),
    //     ),
    //   ),
    // );
  }
}
