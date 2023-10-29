import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/pages/website/submitidea/submitidea.dart';
import 'package:flutter/material.dart';

class SubmitIdeaView extends StatelessWidget {
  final SubmitIdeaController controller;

  const SubmitIdeaView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
        body: Container(),
        context: context);
  }
}
