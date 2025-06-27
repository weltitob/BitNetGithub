import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bitnet/intl/generated/l10n.dart';
import 'package:share_plus/share_plus.dart';

abstract class SocialShare {
  static Future<void> share(String text, BuildContext context) async {
    if (PlatformInfos.isMobile) {
      final box = context.findRenderObject() as RenderBox;
      await SharePlus.instance.share(ShareParams(
          text: text,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size));
    }
    await Clipboard.setData(
      ClipboardData(text: text),
    );
    print("Helpers social share 1");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(L10n.of(context)!.copiedToClipboard)),
    );
    return;
  }
}
