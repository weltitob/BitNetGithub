import 'package:bitnet/backbone/helper/language.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopUpLangPickerWidget extends StatefulWidget {
  const PopUpLangPickerWidget({super.key});

  @override
  State<PopUpLangPickerWidget> createState() => _PopUpLangPickerWidgetState();
}
class _PopUpLangPickerWidgetState extends State<PopUpLangPickerWidget> {
  @override
  Widget build(BuildContext context) {
    Locale? loc = Provider.of<LocalProvider>(context).locale;
     String currentLangCode = Provider.of<LocalProvider>(context).locale.languageCode;
String flag = languageToFlag[currentLangCode]!;
    return     PopupMenuButton<int>(
            constraints: BoxConstraints.loose(Size(32, double.infinity)),
            icon: Text(flag,style: Theme.of(context).textTheme.displaySmall ),
             color: Colors.transparent,
                elevation: 2,
                position: PopupMenuPosition.under,
                offset: Offset(-4, -2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                 itemBuilder: (BuildContext context) {
                  List<PopupMenuEntry<int>> itemList = List.empty(growable: true);
                    for(String code in codeList) {
                      if(code == currentLangCode)
                      continue;
                      itemList.add(PopupMenuItem(
                        padding: EdgeInsets.zero,
                        child: Text(languageToFlag[code]!, style: Theme.of(context).textTheme.displaySmall), 
                        onTap: (){
                        Provider.of<LocalProvider>(context, listen: false)
            .setLocaleInDatabase(code,
            Locale.fromSubtags(languageCode: code), isUser: false);
            setState((){});
                      },));
                    }
                  return itemList;
                 }
            );
  }
}
