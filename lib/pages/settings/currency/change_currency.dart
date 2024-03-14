import 'package:bitnet/backbone/helper/currency/getcurrency.dart';
import 'package:bitnet/backbone/helper/supported_currencies.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/pages/settings/bottomsheet/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:provider/provider.dart';

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        buttonType: ButtonType.transparent,
        onTap: () {
          Provider.of<SettingsProvider>(context, listen: false)
              .switchTab('main');
          },
      ),
      body: DashboardPage(),
    );
  }
}


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  late Map<String, String> currenciesModel = supportedCurrencies;

  @override
  void initState() {
  }

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
                  hintText: lang!.searchC,
                  isSearchEnabled: true,
                  onChanged: (val) {
                    setState(() {
                      search.text = val;
                    });
                  },
                  handleSearch: (dynamic){}),
              currencyData(
                currenciesModel,),
            ],
          ),
        ),
      ),
    );
  }

  Widget currencyData(Map<dynamic,dynamic> currencies,){

    final selectedCurrency = Provider.of<CurrencyChangeProvider>(context).selectedCurrency;

    return SizedBox(
      width: double.infinity,
      child: VerticalFadeListView(
        child: ListView.builder(
          itemCount: currencies.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index){
            List<dynamic> entryList = currencies.keys.toList();
            List<dynamic> valueList = currencies.values.toList();
            return teamData(index, entryList,valueList,currencies, selectedCurrency);
          },
        ),
      ),
    );
  }

  Widget teamData(int index,List<dynamic> keyList,valueList,Map<dynamic,dynamic> curr, selectedCurrency){

    if (search.text.isEmpty) {
      return myCont(keyList[index], valueList[index],curr, selectedCurrency);
    }
    if (valueList[index]
        .toString()
        .toLowerCase()
        .startsWith(search.text.toLowerCase())) {
      return myCont(keyList[index], valueList[index],curr, selectedCurrency);
    }
    return Container();
  }


  Widget myCont(String key,value,Map<dynamic,dynamic> curr, selectedCurrency){

    return BitNetListTile(
      leading: Text(value.toString(), style: Theme.of(context).textTheme.titleMedium,),
      trailing: Text("${getCurrency(key)}", style: Theme.of(context).textTheme.titleMedium,),
      selected: key == selectedCurrency,
      onTap: () {
          print("First Selected");
          print("Key: $key");
          print("Value: $value");
          print("Curr: $curr");

          Provider.of<CurrencyChangeProvider>(context, listen: false)
              .setFirstCurrencyInDatabase(key,);
      },
    );
  }

}

