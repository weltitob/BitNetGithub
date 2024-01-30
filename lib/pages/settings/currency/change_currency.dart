import 'package:bitnet/backbone/futures/fetchRates.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/show_sheet.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/models/currency/rates_model.dart';
import 'package:bitnet/pages/settings/language/change_language.dart';
import 'package:flutter/material.dart';
import 'package:android_id/android_id.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

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
    final lang = L10n.of(context);
    final Get = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context)=> HistoryPage(deviceId: deviceId!)));
          }, icon: const Icon(Icons.history)),
          IconButton(onPressed: (){
            showSheet(context, const LanguagePickerSheet());
          }, icon: const Icon(Icons.language)),
        ],
        automaticallyImplyLeading: false,
        title: Text(lang!.cc,style: const TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: Get.height * 0.06,
                width: Get.width,
                padding: const EdgeInsets.only(left: 10,bottom: 5),
                margin: const EdgeInsets.only(top: 15),
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
                    hintText: lang.searchC,
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
                height: MediaQuery.of(context).size.height * 0.77,
                width: double.infinity,
                child: FutureBuilder<RatesModel>(
                    future: ratesModel,
                    builder: (context, snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(),);
                      } else {
                        return FutureBuilder<Map>(
                            future: currenciesModel,
                            builder: (context, index){
                              if (index.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator(),);
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
      ),
    );
  }

  Widget currencyData(Map<dynamic,dynamic> currencies,final rates){
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        itemCount: currencies.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 20),
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index){
          List<dynamic> entryList = currencies.keys.toList();
          List<dynamic> valueList = currencies.values.toList();
          return teamData(index, entryList,valueList,rates,currencies);
        },
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: (){
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context)=> ConversionCard(
          //           rates: rates,
          //           currencies: curr,
          //           selectedCurrency: key,
          //           deviceId: deviceId!,
          //         )));
        },
        child: Column(
          children: [
            Row(
              children: [
                Text("${getCurrency(key)} :  "),
                Text(value.toString()),
              ],
            ),
            const Divider(color: Colors.white24),
          ],
        ),
      ),
    );
  }

  String getCurrency(String cuName) {
    var format = NumberFormat.simpleCurrency(name: cuName);
    return format.currencySymbol;
  }

}

