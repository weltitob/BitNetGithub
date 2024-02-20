import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:flutter/material.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/backbone/helper/language.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

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
      body: SingleChildScrollView(child: LanguagePickerSheet()),
    );
  }
}

class LanguagePickerSheet extends StatefulWidget {
  const LanguagePickerSheet({super.key});

  @override
  State<LanguagePickerSheet> createState() => _LanguagePickerSheetState();
}

class _LanguagePickerSheetState extends State<LanguagePickerSheet> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final get = MediaQuery.of(context).size;
    final lang = L10n.of(context);
    return Container(
      height: get.height * 0.8,
      width: get.width,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
        child: Column(
          children: [
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
                height: get.height * 0.62,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: flagList.length,
                  itemBuilder: (context, index) {
                    if (search.text.isEmpty) {
                      return languageBox(index);
                    }
                    if (languageList[index]
                        .toString()
                        .toLowerCase()
                        .startsWith(search.text.toLowerCase())) {
                      return languageBox(index);
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

  Widget languageBox(int index) {
    return BitNetListTile(
      leading: Text(
        flagList[index],
        style: Theme.of(context).textTheme.titleLarge,
      ),
      text: languageList[index],
      onTap: () {
        Provider.of<LocalProvider>(context, listen: false)
            .setLocaleInDatabase(codeList[index],
                Locale.fromSubtags(languageCode: codeList[index]));
        Navigator.pop(context);
      },
    );
  }
}
