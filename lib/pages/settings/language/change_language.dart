import 'package:bitnet/backbone/helper/language.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({super.key});
  
  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: 'Change Language',
        context: context,
        buttonType: ButtonType.transparent,
        onTap: () {
          print("pressed");
            final controller = Get.find<SettingsController>();
            controller .switchTab('main');
        },
      ),
      body: SingleChildScrollView(child: LanguagePickerSheet(onTapLanguage: (langCode, locale) {
          Provider.of<LocalProvider>(context, listen: false)
            .setLocaleInDatabase(langCode,
            locale);
            setState((){});
      },)),
    );
  }
}

class LanguagePickerSheet extends StatefulWidget {
  const LanguagePickerSheet({super.key, required this.onTapLanguage});
  final Function(String langCode, Locale locale) onTapLanguage;
  @override
  State<LanguagePickerSheet> createState() => _LanguagePickerSheetState();
}

class _LanguagePickerSheetState extends State<LanguagePickerSheet> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final currentLanguage = Provider.of<LocalProvider>(context).locale;
    final get = MediaQuery.of(context).size;
    final lang = L10n.of(context);

    return Container(
      //height: get.height * 0.8,
      width: get.width,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
        child: Column(
          children: [
            SizedBox(height: AppTheme.cardPadding * 2,),
            SearchFieldWidget(
                hintText: lang!.searchL,
                isSearchEnabled: true,
                //controller: search,
                onChanged: (val) {
                  setState(() {
                    search.text = val;
                  });
                },
                handleSearch: (dynamic) {}),
            VerticalFadeListView(
              child: SizedBox(
                width: get.width,
               // height: get.height * 0.62,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: flagList.length,
                  itemBuilder: (context, index) {
                    if (search.text.isEmpty) {
                      return languageBox(index, currentLanguage);
                    }
                    if (languageList[index]
                        .toString()
                        .toLowerCase()
                        .startsWith(search.text.toLowerCase())) {
                      return languageBox(index, currentLanguage);
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget languageBox(int index, currentLanguage) {
    final locale = Locale.fromSubtags(languageCode: codeList[index]);

    return BitNetListTile(
      leading: Text(
        flagList[index],
        style: Theme.of(context).textTheme.titleLarge,
      ),
      selected: currentLanguage == locale ? true : false,
      text: languageList[index],
      onTap: () {
        // Provider.of<LocalProvider>(context, listen: false)
        //     .setLocaleInDatabase(codeList[index],
        //     locale);
        //     setState((){});
        widget.onTapLanguage(codeList[index], locale);
        //Navigator.pop(context);
      },
    );
  }
}
