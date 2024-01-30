import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final leftIcon;
  final rightIcon;
  final title;
  final leftIconWidth;

  const Header({
    Key? key,
    this.leftIcon,
    this.rightIcon,
    this.title,
    this.leftIconWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      centerTitle: false,
      leadingWidth: leftIconWidth ?? 0,
      leading: leftIcon ??
          const Center(
              child: SizedBox(
            width: 0,
            height: 0,
          )),
      title: title ?? Container(),
      actions: [rightIcon ?? Container()],
    );
    // ClipRect(
    //   child: BackdropFilter(
    //     filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
    //     child: Container(
    //       decoration: const BoxDecoration(
    //         color: Color.fromRGBO(21, 27, 34, 0.1),
    //       ),
    //       child:
    //     ),
    //   ),
    // )
  }
}
