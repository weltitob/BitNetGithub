import 'package:bitnet/components/appstandards/mydivider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class UsdModel {
  final num price;
  final num volume24h;
  final num percentChange_1h;
  final num percentChange_24h;
  final num percentChange_7d;
  final num percentChange_30d;
  final num percentChange_60d;
  final num percentChange_90d;
  final num marketCap;
  final String lastUpdated;

  UsdModel(
      {required this.price,
      required this.volume24h,
      required this.percentChange_1h,
      required this.percentChange_24h,
      required this.percentChange_7d,
      required this.percentChange_30d,
      required this.percentChange_60d,
      required this.percentChange_90d,
      required this.marketCap,
      required this.lastUpdated});

  factory UsdModel.fromJson(Map<String, dynamic> json) {
    return UsdModel(
      price: json["price"] == null ? 0.0 : json["price"],
      volume24h: json["volume_24"] == null ? 0.0 : json["volume_24"],
      percentChange_1h:
          json["percent_change_1h"] == null ? 0.0 : json["percent_change_1h"],
      percentChange_24h:
          json["percent_change_24h"] == null ? 0.0 : json["percent_change_24h"],
      percentChange_7d:
          json["percent_change_7d"] == null ? 0.0 : json["percent_change_7d"],
      percentChange_30d:
          json["percent_change_30d"] == null ? 0.0 : json["percent_change_7d"],
      percentChange_60d:
          json["percent_change60d"] == null ? 0.0 : json["percent_change60d"],
      percentChange_90d:
          json["percent_change90d"] == null ? 0.0 : json["percent_change90d"],
      marketCap: json["market_cap"] == null ? 0.0 : json["market_cap"],
      lastUpdated: json["last_updated"],
    );
  }
}

class QuoteModel {
  final UsdModel usdModel;

  QuoteModel({
    required this.usdModel,
  });
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      usdModel: UsdModel.fromJson(json["USD"]),
    );
  }
}

class DataModel {
  final int id;
  final String name;
  final String symbol;
  final String slug;
  final int numMarketPairs;
  final String dateAdded;
  final List<dynamic> tags;
  final int maxSupply;
  final num circulatingSupply;
  final num totalSupply;
  final int cmcRank;
  final String lastUpdated;
  final QuoteModel quoteModel;

  DataModel(
      this.id,
      this.name,
      this.symbol,
      this.slug,
      this.numMarketPairs,
      this.dateAdded,
      this.tags,
      this.maxSupply,
      this.circulatingSupply,
      this.totalSupply,
      this.cmcRank,
      this.lastUpdated,
      this.quoteModel);

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      json["id"],
      json["name"],
      json["symbol"],
      json["slug"],
      json["num_market_pairs"],
      json["date_added"],
      json["tags"],
      json["max_supply"] == null ? 0 : json["max_supply"],
      json["circulating_supply"],
      json["total_supply"],
      json["cmc_rank"],
      json["last_updated"],
      QuoteModel.fromJson(json["quote"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'slug': slug,
      'num_market_pairs': numMarketPairs,
      'date_added': dateAdded,
      'tags': tags,
      'max_supply': maxSupply,
      'circulating_supply': circulatingSupply,
      'total_supply': totalSupply,
      'cmc_rank': cmcRank,
      'last_updated': lastUpdated,
      'quote': quoteModel,
    };
  }
}

class buildKeymetrics extends StatefulWidget {
  const buildKeymetrics({
    Key? key,
  }) : super(key: key);

  @override
  _buildKeymetricsState createState() => _buildKeymetricsState();
}

class _buildKeymetricsState extends State<buildKeymetrics> {
  late dynamic bottom1day;
  late dynamic top1day;
  late dynamic bottom52week;
  late dynamic top52week;
  late dynamic currentprice;

  @override
  Widget build(BuildContext context) {
    //Formatteddata
    var formattedMarketCap =
        ""; //NumberFormat.compactLong().format(widget.coin.quoteModel.usdModel.marketCap);
    var formattedCircSupply =
        ""; //NumberFormat.compactLong().format(widget.coin.circulatingSupply);
    var formattedMinPrice =
        ""; //NumberFormat.compact().format(widget.coin.quoteModel.usdModel.price);
    var formattedMaxPrice =
        ""; //NumberFormat.compact().format(widget.coin.quoteModel.usdModel.price);
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChildbuildInformation("Market cap:", "${formattedMarketCap}"),
          ChildbuildInformation(
              "Circulating supply:", "${formattedCircSupply}"),
          //widget.coin.maxSupply == 0 ?
          ChildbuildInformation("Max supply:", "unlimited"),
          MyDivider(),
          ChildbuildKeyMetrics2(
            "1-day:",
            formattedMinPrice.toString(),
            formattedMaxPrice.toString(),
            0.0,
            100000.0,
          ),
          ChildbuildKeyMetrics2(
            "52-week:",
            formattedMinPrice.toString(),
            formattedMaxPrice.toString(),
            0.0,
            100000.0,
          ),
          MyDivider(),
          ChildbuildKeyMetrics("Mining:", "713,27", "Mining:", "703,90"),
          ChildbuildKeyMetrics("Volume:", "${""}", "Aver. Vol.:", "22.970.134"),
          MyDivider(),
          ChildbuildKeyMetrics("Long:", "801,74M", "Supply:", "990,01M"),
          ChildbuildKeyMetrics("Short:", "29,91M", "Locked:", "1,41"),
          MyDivider(),
          buildInformation(),
        ],
      ),
    );
  }

  Widget ChildbuildInformation(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          Text(
            text2,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget ChildbuildKeyMetrics3() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                L10n.of(context)!.intrinsicValue,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(
                left: 5,
              )),
              const Text(
                "\$20.11",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          InkWell(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.redAccent),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.trending_down,
                    color: Colors.white,
                    size: 14,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 5)),
                  Text(L10n.of(context)!.bear,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget ChildbuildKeyMetrics2(
    String toptext,
    String minstring,
    String maxstring,
    min,
    max,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            toptext,
            style: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          height: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                minstring,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Container(
                width: 175,
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.grey,
                      inactiveTrackColor: Colors.grey,
                      trackShape: const RectangularSliderTrackShape(),
                      trackHeight: 3.0,
                      thumbColor: max / 2 >
                              2 //widget.coin.quoteModel.usdModel.price.toDouble()
                          ? Colors.redAccent
                          : Colors.greenAccent,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 5.0),
                      overlayColor: max / 2 >
                              2 // widget.coin.quoteModel.usdModel.price.toDouble()
                          ? Colors.red.withAlpha(32)
                          : Colors.green.withAlpha(32),
                    ),
                    child: Slider(
                      value:
                          20, // widget.coin.quoteModel.usdModel.price.toDouble(),
                      min: min,
                      max: max,
                      label:
                          "", //widget.coin.quoteModel.usdModel.price.round().toString(),
                      onChanged: (double value) {},
                    )),
              ),
              Text(
                maxstring,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget ChildbuildKeyMetrics(
    String text1,
    String text2,
    String text3,
    String text4,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text1,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                Text(
                  text2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 7.5)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text3,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                Text(
                  text4,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            "Bitcoin ist ein.... brrr",
            style: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
        buildSeeMore(),
      ],
    );
  }

  Widget buildSeeMore() {
    return Padding(
      padding: const EdgeInsets.only(top: 7.5),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          L10n.of(context)!.seeMore,
          style: const TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
