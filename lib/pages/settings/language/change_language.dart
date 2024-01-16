import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';


class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        text: 'Change Language',
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
