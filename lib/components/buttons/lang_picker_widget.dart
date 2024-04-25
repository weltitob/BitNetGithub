import 'package:bitnet/backbone/helper/language.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/pages/settings/language/change_language.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
return TextButton(child: Text(flag, style: Theme.of(context).textTheme.displaySmall), onPressed: (){
  BitNetBottomSheet(
                        height: MediaQuery.of(context).size.height * 0.7,
                    borderRadius: AppTheme.borderRadiusBig,

    child: StatefulBuilder(
    builder: (BuildContext context, StateSetter setModalState) {
      return Container(
        decoration: BoxDecoration(
             color: Theme.of(context)
                                      .canvasColor, // Add a background color here
                                  borderRadius: new BorderRadius.only(
                                    topLeft: AppTheme.cornerRadiusBig,
                                    topRight: AppTheme.cornerRadiusBig,
                                  ),
        ),
        child: ClipRRect(
                                        borderRadius: new BorderRadius.only(
                                      topLeft: AppTheme.cornerRadiusBig,
                                      topRight: AppTheme.cornerRadiusBig,
                                    ),
        
          child: bitnetScaffold(
              extendBodyBehindAppBar: true,
              context: context,
              appBar: bitnetAppBar(
                text: 'Change Language',
                context: context,
                buttonType: ButtonType.transparent,
                onTap: () {
                  context.pop();
                },
              ),
              body: SingleChildScrollView(child: LanguagePickerSheet(onTapLanguage: (langCode, locale) {
                  Provider.of<LocalProvider>(context, listen: false)
                    .setLocaleInDatabase(langCode,
                    locale, isUser: false);
                    setState((){});
              },)),
            ),
        ),
      );
    }
  ), context: context);
},);
    // return     PopupMenuButton<int>(
    //         constraints: BoxConstraints.loose(Size(32, double.infinity)),
    //         icon: Text(flag,style: Theme.of(context).textTheme.displaySmall ),
    //          color: Colors.transparent,
    //             elevation: 2,
    //             position: PopupMenuPosition.under,
    //             offset: Offset(-4, -2),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(24),
    //             ),
    //              itemBuilder: (BuildContext context) {
    //               List<PopupMenuEntry<int>> itemList = List.empty(growable: true);
    //                 for(String code in codeList) {
    //                   if(code == currentLangCode)
    //                   continue;
    //                   itemList.add(PopupMenuItem(
    //                     padding: EdgeInsets.zero,
    //                     child: Text(languageToFlag[code]!, style: Theme.of(context).textTheme.displaySmall), 
    //                     onTap: (){
    //                     Provider.of<LocalProvider>(context, listen: false)
    //         .setLocaleInDatabase(code,
    //         Locale.fromSubtags(languageCode: code), isUser: false);
    //         setState((){});
    //                   },));
    //                 }
    //               return itemList;
    //              }
    //         );
  }
}
