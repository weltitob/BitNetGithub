import 'package:BitNet/components/appstandards/BitNetAppBar.dart';
import 'package:BitNet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';

class SocialRecoveryScreen extends StatefulWidget {
  const SocialRecoveryScreen({Key? key}) : super(key: key);

  @override
  State<SocialRecoveryScreen> createState() => _SocialRecoveryScreenState();
}

class _SocialRecoveryScreenState extends State<SocialRecoveryScreen> {
  @override
  Widget build(BuildContext context) {
    return BitNetScaffold(
      appBar: BitNetAppBar(
          text: "Social recovery",
          context: context,
          onTap: (){
            Navigator.of(context).pop();
          }),
        body: Container(),
        context: context);
  }
}
