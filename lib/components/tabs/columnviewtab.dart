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
      print("REQUESTING FETCHTAPROOT ASSETS NOW");
      List<Asset> fetchedAssets = await listTaprootAssets();
      setState(() {
        assets = fetchedAssets;
        isLoading = false;
      });
      print("RESPONSE: $assets");
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          LongButtonWidget(
            title: "FETCH ASSETS",
            onTap: fetchTaprootAssets,
          ),
          if (isLoading)
            Center(child: dotProgress(context))
          else if (assets.isEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error),
                SizedBox(height: AppTheme.cardPadding),
                Text(
                  'No assets found',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: assets.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(assets[index].assetGenesis.name),
                    subtitle: Text('Amount: ${assets[index].amount}'),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
