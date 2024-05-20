import 'package:bitnet/backbone/cloudfunctions/taprootassets/list_assets.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/tapd/asset.dart';
import 'package:flutter/material.dart';

class ColumnViewTab extends StatefulWidget {
  const ColumnViewTab({super.key});

  @override
  State<ColumnViewTab> createState() => _ColumnViewTabState();
}

class _ColumnViewTabState extends State<ColumnViewTab> {
  bool isLoading = false;
  List<Asset> assets = [];

  @override
  void initState() {
    super.initState();
  }

  void fetchTaprootAssets() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Asset> fetchedAssets = await listTaprootAssets();
      setState(() {
        assets = fetchedAssets.reversed.toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if(!isLoading)LongButtonWidget(
            title: "FETCH ASSETS",
            onTap: fetchTaprootAssets,
          ),
          if (isLoading)
            Center(child: dotProgress(context))
          else if (assets.isEmpty)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error),
                  SizedBox(width: AppTheme.cardPadding),
                  Text(
                    'No assets found',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: assets.length,
              itemBuilder: (context, index) {
                // jz hier stattdessen meine posts quasie einfügen und dann die posts anzeigen lassen clean (muss noch die daten decoden teilweise)
                //je nachdem was drin steht im asset entsprechend anzeigen jz mal heute das hall fineny quote als cleanen post
                return ListTile(
                  title: Text(assets[index].assetGenesis.name),
                  subtitle: Text('Amount: ${assets[index].amount}'),
                );
              },
            ),
        ],
      ),
    );
  }
}
