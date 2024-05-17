import 'package:bitnet/backbone/helper/language.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/pages/settings/language/change_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PopUpLangPickerWidget extends StatefulWidget {
  const PopUpLangPickerWidget({super.key});

  @override
  State<PopUpLangPickerWidget> createState() => _PopUpLangPickerWidgetState();
}

class _PopUpLangPickerWidgetState extends State<PopUpLangPickerWidget> {
  @override
  Widget build(BuildContext context) {
    // Locale? loc = Provider.of<LocalProvider>(context).locale;
    String currentLangCode =
        Provider.of<LocalProvider>(context).locale.languageCode;
    String flag = languageToFlag[currentLangCode]!;
    return TextButton(
      child: Text(flag, style: Theme.of(context).textTheme.displaySmall),
      onPressed: () {
        BitNetBottomSheet(
            height: MediaQuery.of(context).size.height * 0.65.h,
            borderRadius: AppTheme.borderRadiusBig,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .canvasColor, // Add a background color here
                    borderRadius: new BorderRadius.only(
                      topLeft: AppTheme.cornerRadiusBig.w,
                      topRight: AppTheme.cornerRadiusBig.w,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: AppTheme.cornerRadiusBig.w,
                      topRight: AppTheme.cornerRadiusBig.w,
                    ),
                  
                    child: bitnetScaffold(
                      extendBodyBehindAppBar: true,
                      context: context,
                      appBar: bitnetAppBar(
                        hasBackButton: false,
                        text: 'Change Language',
                        context: context,
                        buttonType: ButtonType.transparent,
                      ),
                      body: LanguagePickerSheet(
                        onTapLanguage: (langCode, locale) {
                          Provider.of<LocalProvider>(context, listen: false)
                              .setLocaleInDatabase(langCode, locale,
                                  isUser: false);
                          setState(() {});
                          // context.go('/authhome');
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            context: context);
      },
    );
  }
}
