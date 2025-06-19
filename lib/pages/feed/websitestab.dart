import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WebsitesTab extends StatefulWidget {
  const WebsitesTab({Key? key}) : super(key: key);

  @override
  State<WebsitesTab> createState() => _WebsitesTabState();
}

class _WebsitesTabState extends State<WebsitesTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
    return GlassContainer(
      padding: EdgeInsets.all(AppTheme.elementSpacing),
      child: InkWell(
        onTap: () {
          context.push('/feed/webview/${Uri.encodeComponent(url)}/${Uri.encodeComponent(title)}');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BitNetImageWithTextButton(
              title,
              () {
                context.push('/feed/webview/${Uri.encodeComponent(url)}/${Uri.encodeComponent(title)}');
              },
              image: imagePath,
              width: AppTheme.cardPadding * 4,
              height: AppTheme.cardPadding * 4,
            ),
          ],
        ),
      ),
    );
  }
}