import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/BitNetWebsiteAppBar.dart';
import 'package:bitnet/pages/website/contact/report/report.dart';
import 'package:flutter/material.dart';

class ReportView extends StatelessWidget {
  final ReportController controller;

  const ReportView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        appBar: bitnetWebsiteAppBar(),
        body: Container(

        ), context: context);
  }
}
