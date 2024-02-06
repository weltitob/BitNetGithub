import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
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
      body: SingleChildScrollView(
        child: LanguagePickerSheet()
      ),
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
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Container(
                height: 2,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Container(
              height: get.height * 0.06,
              width: get.width,
              padding: const EdgeInsets.only(left: 10,bottom: 5),
              margin: const EdgeInsets.only(top: 20,bottom: 25),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color : Colors.grey.shade400),
              ),
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    search.text = val;
                  });
                },
                cursorColor: Colors.white,
                controller: search,
                decoration: InputDecoration(
                  hintText: lang!.searchL,
                  hintStyle: const TextStyle(fontSize: 14),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: get.width,
              height: get.height * 0.62,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemCount: flagList.length,
                itemBuilder: (context,index){

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
          ],
        ),
      ),
    );
  }

  Widget languageBox(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: (){
          Provider.of<LocalProvider>(context, listen: false)
              .setLocaleInDatabase(codeList[index],Locale.fromSubtags(languageCode: codeList[index]));
          Navigator.pop(context);
        },
        child: Column(
          children: [
            Row(
              children: [
                Text(flagList[index],style: const TextStyle(fontSize: 20),),
                const SizedBox(width: 8),
                Text(languageList[index],style: const TextStyle(fontSize: 16),),
              ],
            ),
            const Divider(color: Colors.white24),
          ],
        ),
      ),
    );
  }

}

