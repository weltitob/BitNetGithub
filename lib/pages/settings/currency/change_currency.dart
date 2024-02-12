import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:flutter/material.dart';

class ChangeCurrency extends StatefulWidget {
  const ChangeCurrency({super.key});

  @override
  State<ChangeCurrency> createState() => _ChangeCurrencyState();
}

class _ChangeCurrencyState extends State<ChangeCurrency> {
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        text: 'Change Currency',
        context: context,
        onTap: () {
          print("pressed");
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Change Currency'),
            //use the widget below
            //SearchFieldWidget
          ],
        ),
      ),
    );
  }
}
