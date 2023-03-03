import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class BitcoinPrice extends StatefulWidget {
  @override
  _BitcoinPriceState createState() => _BitcoinPriceState();
}

class _BitcoinPriceState extends State<BitcoinPrice> {
  StreamController<double> _priceStreamController =
  StreamController<double>();

  @override
  void initState() {
    super.initState();
    _getBitcoinPrice();
  }

  @override
  void dispose() {
    _priceStreamController.close();
    super.dispose();
  }

  void _getBitcoinPrice() async {
    final String url = 'https://api.coingecko.com/api/v3/simple/price';
    final Map<String, String> params = {
      'ids': 'bitcoin',
      'vs_currencies': 'eur',
      'include_last_updated_at': 'true'
    };

    final response =
    await get(Uri.parse(url).replace(queryParameters: params), headers: {});

    if (response.statusCode == 200) {
      final price = jsonDecode(response.body)['bitcoin']['eur'];
      final time = jsonDecode(response.body)['bitcoin']['last_updated_at'];
      setState(() {
        _priceStreamController.add(price);
      });
    } else {
      print('Error ${response.statusCode}: ${response.reasonPhrase}');
      setState(() {
        print("An Error occured trying to livefetch the bitcoinprice");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Center(
        child: StreamBuilder<double>(
          stream: _priceStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                '\$${snapshot.data!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}