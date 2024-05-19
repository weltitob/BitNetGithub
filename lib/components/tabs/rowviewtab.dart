import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:flutter/material.dart';

class RowViewTab extends StatefulWidget {
  @override
  _RowViewTabState createState() => _RowViewTabState();
}

class _RowViewTabState extends State<RowViewTab>
    with SingleTickerProviderStateMixin {
  bool get wantKeepAlive => true;

  late bool fixedScroll;
  String watchlist = "";
  bool _loading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(),
    );
  }
}