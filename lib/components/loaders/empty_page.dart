import 'dart:math';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final bool loading;
  final String text;
  static const double _width = 300;
  const EmptyPage({this.loading = false, this.text = '', Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = min(MediaQuery.of(context).size.width, EmptyPage._width) / 2;
    return Scaffold(
      // Add invisible appbar to make status bar on Android tablets bright.
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Hero(
              tag: 'info-logo',
              child: Image.asset(
                'assets/images/logoclean.png',
                width: width,
                height: width,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
          SizedBox(height: AppTheme.cardPadding,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
          ),
          SizedBox(height: AppTheme.cardPadding,),
          if (loading)
            Center(
              child: SizedBox(
                width: width,
                child: dotProgress(context),
              ),
            ),
          SizedBox(height: AppTheme.cardPadding,),
          LongButtonWidget(buttonType: ButtonType.transparent, title: "ESCAPE BUTTON", onTap:
              (){
            Auth().signOut();}
          ),
        ],
      ),
    );
  }
}
