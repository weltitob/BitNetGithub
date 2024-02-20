import 'package:bitnet/backbone/futures/fetchRates.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/streams/currency_provider.dart';
import 'package:bitnet/backbone/streams/locale_provider.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/fadelistviewwrapper.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/currency/rates_model.dart';
import 'package:flutter/material.dart';
import 'package:android_id/android_id.dart';
import 'package:intl/intl.dart';
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
        onTap: () {
          print("pressed");
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

  late Future<RatesModel> ratesModel;
  late Future<Map> currenciesModel;

  bool firstSelected = true;
  bool secondSelected = false;

  void selectFirstCurrency(){
    setState(() {
      secondSelected = false;
      firstSelected = true;
    });
  }

  void selectSecondCurrency(){
    setState(() {
      secondSelected = true;
      firstSelected = false;
    });
  }

  @override
  void initState() {
    getAndroidId();
    super.initState();
    _fetchData();
  }

  final _androidIdPlugin = const AndroidId();

  String? deviceId;

  void getAndroidId() async {
    deviceId = await _androidIdPlugin.getId();
    print("ANDROID IDDDD $deviceId");
  }

  Future<void> _fetchData() async {
    ratesModel = fetchRates();
    currenciesModel = fetchCurrencies();
  }

  TextEditingController search = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final firstCurrency = Provider.of<CurrencyChangeProvider>(context).firstCurrency;
    final secondCurrency = Provider.of<CurrencyChangeProvider>(context).secondCurrency;

    final lang = L10n.of(context);
    final Get = MediaQuery.of(context).size;
    return bitnetScaffold(
      context: context,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing),
        child: Column(
          children: [
            BitNetListTile(
              selected: firstSelected,
              customTitle: Text("Main Currency"),
              leading: Text("1."),
              trailing: Text("$firstCurrency", style: Theme.of(context).textTheme.titleMedium,),
              //customTitle: Text("Currency"),
              onTap: () {
                selectFirstCurrency();
              },
            ),
            BitNetListTile(
              selected: secondSelected,
              customTitle: Text("Secondary Currency"),
              leading: Text("2."),
              trailing: Text("$secondCurrency", style: Theme.of(context).textTheme.titleMedium,),
              //customTitle: Text("Currency"),
              onTap: () {
                selectSecondCurrency();
              },
            ),
            SizedBox(height: AppTheme.elementSpacing,),
            SearchFieldWidget(
                hintText: lang!.searchC,
                isSearchEnabled: true,
                onChanged: (val) {
                  setState(() {
                    search.text = val;
                  });
                },
                handleSearch: (dynamic){}),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              child: FutureBuilder<RatesModel>(
                  future: ratesModel,
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: dotProgress(context),);
                    } else {
                      return FutureBuilder<Map>(
                          future: currenciesModel,
                          builder: (context, index){
                            if (index.connectionState == ConnectionState.waiting) {
                              return Center(child: dotProgress(context),);
                            } else if (index.hasError) {
                              return Center(child: Text('Error: ${index.error}'));
                            } else {
                              return currencyData(
                                index.data!,
                                snapshot.data!.rates,
                              );
                              // return ConversionCard(
                              //   rates: snapshot.data!.rates,
                              //   currencies: index.data!,
                              // );
                            }
                          }
                      );
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget currencyData(Map<dynamic,dynamic> currencies,final rates){
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
            return teamData(index, entryList,valueList,rates,currencies);
          },
        ),
      ),
    );
  }

  Widget teamData(int index,List<dynamic> keyList,valueList,final rates,Map<dynamic,dynamic> curr){

    if (search.text.isEmpty) {
      return myCont(keyList[index], valueList[index],rates,curr);
    }
    if (valueList[index]
        .toString()
        .toLowerCase()
        .startsWith(search.text.toLowerCase())) {
      return myCont(keyList[index], valueList[index],rates,curr);
    }
    return Container();
  }


  Widget myCont(String key,value,final rates,Map<dynamic,dynamic> curr){
    return BitNetListTile(
      leading: Text(value.toString(), style: Theme.of(context).textTheme.bodyMedium,),
      trailing: Text("${getCurrency(key)}", style: Theme.of(context).textTheme.titleMedium,),
      onTap: () {
        if(firstSelected){
          print("First Selected");
          print("Key: $key");
          print("Value: $value");
          print("Rates: $rates");
          print("Curr: $curr");
          Provider.of<CurrencyChangeProvider>(context, listen: false)
              .setFirstCurrencyInDatabase(key,);
        } else {
          print("Second Selected");
          print("Key: $key");
          print("Value: $value");
          print("Rates: $rates");
          print("Curr: $curr");
          Provider.of<CurrencyChangeProvider>(context, listen: false)
             .setSecondCurrencyInDatabase(key,);
        }
      },
    );
  }

  String getCurrency(String cuName) {
    var format = NumberFormat.simpleCurrency(name: cuName);
    return format.currencySymbol;
  }

}

