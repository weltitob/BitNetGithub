import 'package:bitnet/backbone/helper/matrix_helpers/url_launcher.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/pages/chat_list/createnew/new_private_chat/new_private_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';

import 'package:bitnet/backbone/helper/social_share.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';


class NewPrivateChat extends StatefulWidget {
  const NewPrivateChat({Key? key}) : super(key: key);

  @override
  NewPrivateChatController createState() => NewPrivateChatController();
}

class NewPrivateChatController extends State<NewPrivateChat> {
  final TextEditingController controller = TextEditingController();
  final FocusNode textFieldFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  // remove leading matrix.to from text field in order to simplify pasting
  final List<TextInputFormatter> removeMatrixToFormatters = [
    FilteringTextInputFormatter.deny(NewPrivateChatController.prefix),
    FilteringTextInputFormatter.deny(NewPrivateChatController.prefixNoProtocol),
  ];

  static const Set<String> supportedSigils = {'@', '!', '#'};

  static const String prefix = 'https://matrix.to/#/';
  static const String prefixNoProtocol = 'matrix.to/#/';

  void submitAction([_]) async {
    controller.text = controller.text.trim();
    if (!formKey.currentState!.validate()) return;
    UrlLauncher(context, '$prefix${controller.text}').openMatrixToUrl();
  }

  String? validateForm(String? value) {
    if (value!.isEmpty) {
      return L10n.of(context)!.pleaseEnterAMatrixIdentifier;
    }
    if (!controller.text.isValidMatrixId ||
        !supportedSigils.contains(controller.text.sigil)) {
      return L10n.of(context)!.makeSureTheIdentifierIsValid;
    }
    if (controller.text == Matrix.of(context).client.userID) {
      return L10n.of(context)!.youCannotInviteYourself;
    }
    return null;
  }

  void inviteAction() => SocialShare.share(
        'https://matrix.to/#/${Matrix.of(context).client.userID}',
        context,
      );

  void openScannerAction() async {

    if (PlatformInfos.isAndroid) {
      final info = await DeviceInfoPlugin().androidInfo;

      //hier stattdessen auf eigenen qrscreen mit notwenigen infos forwarden
      if (info.version.sdkInt < 21) {
        showOverlay(
          context,
          L10n.of(context)!.unsupportedAndroidVersionLong,
        );
        return;
      }


    }

    context.push('/qrscanner');

    // await showAdaptiveBottomSheet(
    //   context: context,
    //   builder: (_) => const QrScannerModal(),
    // );
  }

  @override
  Widget build(BuildContext context) => NewPrivateChatView(this);
}
