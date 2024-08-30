import 'package:bitnet/backbone/helper/language.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
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
    final controller = Get.find<SettingsController>();
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.changeLanguage,
        context: context,
        buttonType: ButtonType.transparent,
        onTap: () {
          controller.switchTab('main');
        },
      ),
      body: const LanguagePickerPage(),
    );
  }
} 
class LanguagePickerPage extends StatefulWidget {
  const LanguagePickerPage({super.key});

  @override
  State<LanguagePickerPage> createState() => _LanguagePickerPageState();
}

class _LanguagePickerPageState extends State<LanguagePickerPage> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lang = L10n.of(context);

    return bitnetScaffold(
      context: context,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchFieldWidget(
                  hintText: lang!.searchL,
                  isSearchEnabled: true,
                  onChanged: (val) {
                    setState(() {
                      search.text = val;
                    });
                  },
                  handleSearch: (dynamic) {}),
              languageData(
                languageList,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget languageData(
      List<String> languages,
      ) {
    final selectedLanguage = Provider.of<LocalProvider>(context).locale;

    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        itemCount: languages.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return languageBox(index, languages, selectedLanguage);
        },
      ),
    );
  }

  Widget languageBox(int index, List<String> languages, Locale selectedLanguage) {
    final locale = Locale.fromSubtags(languageCode: codeList[index]);
    if (search.text.isEmpty) {
      return myLanguageTile(languages[index], locale, selectedLanguage);
    }
    if (languages[index].toLowerCase().startsWith(search.text.toLowerCase())) {
      return myLanguageTile(languages[index], locale, selectedLanguage);
    }
    return Container();
  }

  Widget myLanguageTile(String language, Locale locale, Locale selectedLanguage) {
    return BitNetListTile(
      leading: Text(
        flagList[languageList.indexOf(language)],
        style: Theme.of(context).textTheme.titleLarge,
      ),
      text: language,
      selected: locale == selectedLanguage,
      onTap: () {
        Provider.of<LocalProvider>(context, listen: false)
            .setLocaleInDatabase(codeList[languageList.indexOf(language)], locale);
        Navigator.pop(context);
      },
    );
  }
}