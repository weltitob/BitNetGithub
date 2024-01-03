import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/chat_list/createnew/new_private_chat/new_private_chat.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';

class NewPrivateChatView extends StatefulWidget {
  final NewPrivateChatController controller;

  const NewPrivateChatView(this.controller, {Key? key}) : super(key: key);

  static const double _qrCodePadding = 8;

  @override
  State<NewPrivateChatView> createState() => _NewPrivateChatViewState();
}

class _NewPrivateChatViewState extends State<NewPrivateChatView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // A GlobalKey is used to identify this widget in the widget tree, used to access and modify its properties
    GlobalKey globalKeyQR = GlobalKey();

    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.all(NewPrivateChatView._qrCodePadding * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: Center(
                    child: RepaintBoundary(
                      // The Qr code is generated from this widget's global key
                      key: globalKeyQR,
                      child: Container(
                        margin: const EdgeInsets.all(AppTheme.cardPadding),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: AppTheme.cardRadiusSmall),
                        child: Padding(
                          padding:
                              const EdgeInsets.all(AppTheme.cardPadding / 2),
                          // The Qr code is generated using the pretty_qr package with an image, size, and error correction level
                          child: PrettyQr(
                            image:
                                const AssetImage('assets/images/new_chat.png'),
                            typeNumber: null,
                            size: qrCodeSize(context),
                            data:
                                'https://matrix.to/#/${Matrix.of(context).client.userID}',
                            errorCorrectLevel: QrErrorCorrectLevel.M,
                            roundEdges: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: AppTheme.cardPadding * 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Add a button to copy the wallet address to the clipboard
                      if (PlatformInfos.isMobile) ...[
                        LongButtonWidget(
                          customWidth: AppTheme.cardPadding * 6,
                          customHeight: AppTheme.cardPadding * 2.5,
                          buttonType: ButtonType.transparent,
                          title: "Scan QR",
                          leadingIcon: Icon(
                            Icons.qr_code_2_rounded,
                            size: AppTheme.cardPadding * 0.75,
                            color: AppTheme.white90,
                          ),
                          onTap: () {
                            if (mounted) {
                              widget.controller.openScannerAction();
                            }
                          },
                        ),
                      ],
                      // Add a button to share the wallet address
                      LongButtonWidget(
                        customWidth: AppTheme.cardPadding * 6,
                        customHeight: AppTheme.cardPadding * 2.5,
                        buttonType: ButtonType.transparent,
                        title: "Teilen",
                          leadingIcon: Icon(
                            Icons.share_rounded,
                            size: AppTheme.cardPadding * 0.75,
                            color: AppTheme.white90,
                          ),
                        onTap: () {
                          if (mounted) {
                            widget.controller.inviteAction();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Form(
              key: widget.controller.formKey,
              child: FormTextField(
                controller: widget.controller.controller,
                isObscure: false,
                validator: widget.controller.validateForm,
                textInputAction: TextInputAction.go,
                focusNode: widget.controller.textFieldFocus,
                onFieldSubmitted: widget.controller.submitAction,
                inputFormatters: widget.controller.removeMatrixToFormatters,
                labelText: L10n.of(context)!.enterInviteLinkOrMatrixId,
                hintText: '@username',
                prefixText: NewPrivateChatController.prefixNoProtocol,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send_outlined),
                  onPressed: widget.controller.submitAction,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
