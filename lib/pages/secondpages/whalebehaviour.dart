import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

import 'dart:convert';
import 'package:http/http.dart';

class Analysts {
  final String analystCount;
  final String consensusDate;
  final String marketConsensus;
  final String marketConsensusTargetPrice;

  Analysts({
    required this.analystCount,
    required this.consensusDate,
    required this.marketConsensus,
    required this.marketConsensusTargetPrice,
  });

  factory Analysts.fromJson(Map<String, dynamic> json) {
    return Analysts(
      analystCount: json['analystCount'].toString(),
      consensusDate: json['consensusDate'] as String,
      marketConsensus: json['marketConsensus'].toString(),
      marketConsensusTargetPrice: json['marketConsensusTargetPrice'].toString(),
    );
  }
}

class Keymetrics {
  final String marketcap;
  final String week52high;
  final String week52low;
  final String float;
  final String employees;
  final String peRatio;

  Keymetrics({
    required this.marketcap,
    required this.week52high,
    required this.week52low,
    required this.float,
    required this.employees,
    required this.peRatio,
  });

  factory Keymetrics.fromJson(Map<String, dynamic> json) {
    return Keymetrics(
      marketcap: json['marketcap'].toString(),
      week52high: json['week52high'] as String,
      week52low: json['week52low'].toString(),
      float: json['float'].toString(),
      employees: json['employees'].toString(),
      peRatio: json['peRatio'].toString(),
    );
  }
}

class Insider {
  final String fullName;
  final String transactionValue;
  final String filingDate;

  Insider({
    required this.fullName,
    required this.transactionValue,
    required this.filingDate,
  });

  factory Insider.fromJson(Map<String, dynamic> json) {
    return new Insider(
      fullName: json['fullName'].toString(),
      transactionValue: json['transactionValue'].toString(),
      filingDate: json['filingDate'].toString(),
    );
  }
}

//_______________________________________________________________________

class IEXCloudServicePrice {
  final String stockURL =
      "https://sandbox.iexapis.com/stable/stock/TSLA/quote/latestPrice?token=Tpk_85b3b5cdb32147d3a0fb751cc5176cdd";

  Future<String> getData() async {
    Response res = await get(Uri.parse(stockURL));
    if (res.statusCode == 200) {
      final obj = jsonDecode(res.body);
      return obj.toString();
    } else {
      throw "Unable to retrieve stock data from IEX cloud.";
    }
  }
}

//_________________________________________________________________________
//for the marketConsensusTargetPrice // same as the numberofAnalysts?

class IEXCloudServiceAnalysts {
  Future<List<Analysts>> getData() async {
    var url = Uri.parse(
        "https://sandbox.iexapis.com/stable/time-series/CORE_ESTIMATES/TSLA?token=Tpk_85b3b5cdb32147d3a0fb751cc5176cdd");
    Response res = await get(url);
    return parseAnalysis(res.body);
  }
}

List<Analysts> parseAnalysis(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Analysts>((json) => Analysts.fromJson(json)).toList();
}

class IEXCloudServiceInsider {
  Future<List<Insider>> getInsiderData() async {
    var url = Uri.parse(
        "https://sandbox.iexapis.com/stable/stock/TSLA/insider-transactions?token=Tpk_85b3b5cdb32147d3a0fb751cc5176cdd");
    Response res = await get(url);
    return parseAnalysisInsider(res.body);
  }
}

List<Insider> parseAnalysisInsider(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Insider>((json) => new Insider.fromJson(json)).toList();
}

//_________________________________________________________________________
//KeyMetrics

class IEXCloudServiceKeymetrics {
  Future<List<Keymetrics>> getKeymetricsData() async {
    var url = Uri.parse(
        "https://sandbox.iexapis.com/stable/stock/TSLA/stats?token=Tpk_85b3b5cdb32147d3a0fb751cc5176cdd");
    Response res = await get(url);
    return parseAnalysisKeymetrics(res.body);
  }
}

//https://sandbox.iexapis.com/stable/crypto/btcusd/price?token=Tpk_85b3b5cdb32147d3a0fb751cc5176cdd

List<Keymetrics> parseAnalysisKeymetrics(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Keymetrics>((json) => new Insider.fromJson(json)).toList();
}

class WhaleBehaviour extends StatefulWidget {
  const WhaleBehaviour({Key? key}) : super(key: key);

  @override
  State<WhaleBehaviour> createState() => _WhaleBehaviourState();
}

class _WhaleBehaviourState extends State<WhaleBehaviour> {
  @override
  Widget build(BuildContext context) {
    return InsiderWidget();
  }
}

class InsiderWidget extends StatelessWidget {
  //Cloudservice
  IEXCloudServiceInsider iexcloudinsider = IEXCloudServiceInsider();

  static String? formatter(String number) {
    try {
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      double value = double.parse(number);

      if (value < 1000) {
        // less than a million
        return value.toStringAsFixed(2);
      } else if (value >= 1000 && value < (1000 * 10 * 100)) {
        // less than 1 million
        double result = value / 1000;
        return result.toStringAsFixed(2) + "K";
      } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
        // less than 100 million
        double result = value / 1000000;
        return result.toStringAsFixed(2) + "M";
      } else if (value >= (1000000 * 10 * 100) &&
          value < (1000000 * 10 * 100 * 100)) {
        // less than 100 billion
        double result = value / (1000000 * 10 * 100);
        return result.toStringAsFixed(2) + "B";
      } else if (value >= (1000000 * 10 * 100 * 100) &&
          value < (1000000 * 10 * 100 * 100 * 100)) {
        // less than 100 trillion
        double result = value / (1000000 * 10 * 100 * 100);
        return result.toStringAsFixed(2) + "T";
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      context: context,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.whaleBehavior,
        context: context,
        onTap: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: AppTheme.elementSpacing,
            right: AppTheme.elementSpacing,
            top: AppTheme.cardPadding * 3),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[900],
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 110,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                            size: 12,
                          ),
                          Text(
                            L10n.of(context)!.nameBehavior,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.grey[400],
                            size: 12,
                          ),
                          Text(
                          L10n.of(context)!.dateBehavior,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      child: Row(
                        children: [
                          Icon(Icons.monetization_on_rounded,
                              color: Colors.grey[400], size: 12),
                          Text(
                            L10n.of(context)!.value,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.bar_chart,
                          color: Colors.white,
                          size: 12,
                        ),
                        Text(
                          L10n.of(context)!.typeBehavior,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: MyDividerStandard(),
              ),
              FutureBuilder<List<Insider>>(
                  future: iexcloudinsider.getInsiderData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          ChildbuildWhaleBehavior(
                              "${snapshot.data![0].fullName}",
                              "${snapshot.data![0].filingDate}",
                              "${snapshot.data![0].transactionValue}\$",
                              false,context),
                          ChildbuildWhaleBehavior(
                              "${snapshot.data![1].fullName}",
                              "${snapshot.data![1].filingDate}",
                              "${snapshot.data![1].transactionValue}\$",
                              false,context),
                          ChildbuildWhaleBehavior(
                              "${snapshot.data![2].fullName}",
                              "${snapshot.data![2].filingDate}",
                              "${snapshot.data![2].transactionValue}\$",
                              false,context),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return Text(
                        '${snapshot.error}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:   Text(L10n.of(context)!.noResultsFound,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                      );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget ChildbuildWhaleBehavior(String name, String date, String value, type, BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 110,
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              width: 80,
              child: Text(
                date,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Container(
              width: 80,
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
            type
                ? InkWell(
                    child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 3, bottom: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.trending_up,
                            color: Colors.white,
                            size: 12,
                          ),
                          const Padding(padding: EdgeInsets.only(left: 5)),
                          Text(L10n.of(context)!.buy,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ))
                : InkWell(
                    child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.redAccent),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 5, right: 5, top: 3, bottom: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.trending_down,
                            color: Colors.white,
                            size: 12,
                          ),
                          const Padding(padding: EdgeInsets.only(left: 5)),
                          Text(L10n.of(context)!.sell,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )),
          ],
        ),
      ],
    );
  }

  Widget MyDividerStandard() {
    return const Divider(
      height: 10,
      color: Colors.grey,
    );
  }
}
