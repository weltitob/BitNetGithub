import 'package:bitnet/pages/website/contact/report/report_view.dart';
import 'package:flutter/material.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => ReportController();
}

class ReportController extends State<Report> {

  onAddButton(){
    print("add button pressed");
  }


  @override
  Widget build(BuildContext context) {
    return ReportView(controller: this);
  }
}
