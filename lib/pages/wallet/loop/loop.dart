
import 'package:bitnet/pages/wallet/loop/loop_view.dart';
import 'package:flutter/material.dart';

class Loop extends StatefulWidget {
  const Loop({super.key});

  @override
  State<Loop> createState() => LoopController();
}

class LoopController extends State<Loop> {
  @override
  Widget build(BuildContext context) {
    return LoopScreen();
  }
}
