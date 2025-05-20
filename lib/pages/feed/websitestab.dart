import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetContainer.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WebsitesTab extends StatelessWidget {
  const WebsitesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppTheme.cardPadding.w),
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: AppTheme.elementSpacing.w,
            mainAxisSpacing: AppTheme.elementSpacing.h,
            children: [
              _buildWebsiteItem(
                context,
                "Bitcoin News",
                "assets/images/bitcoin.png",
                "https://bitcoin.org/en/bitcoin-events",
              ),
              _buildWebsiteItem(
                context,
                "Mempool",
                "assets/images/blockchain.png",
                "https://mempool.space",
              ),
              _buildWebsiteItem(
                context,
                "Block Explorer",
                "assets/images/blockchain.png",
                "https://blockstream.info",
              ),
              _buildWebsiteItem(
                context,
                "Lightning Network",
                "assets/images/lightning.png",
                "https://amboss.space",
              ),
              _buildWebsiteItem(
                context,
                "Bitcoin Wiki",
                "assets/images/bitcoin.png",
                "https://en.bitcoin.it/wiki/Main_Page",
              ),
              _buildWebsiteItem(
                context,
                "Bitcoin Stack Exchange",
                "assets/images/bitcoin.png",
                "https://bitcoin.stackexchange.com",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWebsiteItem(
      BuildContext context, String title, String imagePath, String url) {
    return BitNetContainer(
      onTap: () {
        context.push('/feed/webview/${Uri.encodeComponent(url)}/${Uri.encodeComponent(title)}');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BitNetImageWithText(
            imageAsset: imagePath,
            text: title,
            imageSize: AppTheme.cardPadding * 2,
            fontSize: 16,
            textPadding: const EdgeInsets.only(top: AppTheme.elementSpacing),
          ),
        ],
      ),
    );
  }
}