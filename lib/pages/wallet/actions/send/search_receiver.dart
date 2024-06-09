import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/searchfield/searchfield.dart';
import 'package:bitnet/pages/wallet/actions/send/controllers/send_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class SearchReceiver extends GetWidget<SendsController> {
  const SearchReceiver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        text: L10n.of(context)!.chooseReceipient,
        context: context,
        onTap: () {
          context.go('/feed');
        },
      ),
      context: context,
      body: PopScope(
        canPop: false,
        onPopInvoked: (v) {
          context.go('/feed');
        },
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: AppTheme.cardPadding * 2.5,
                ),
                SearchFieldWidget(
                  hintText: L10n.of(context)!.searchReceipient,
                  isSearchEnabled: true,
                  handleSearch: controller.handleSearch,
                  node: controller.myFocusNodeAdressSearch,
                  
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    controller: controller.sendScrollerController,
                    
                    reverse: false,
                    child: Container(
                                height: MediaQuery.of(context).size.height * 1.5,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(height: 1)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            BottomCenterButton(
              onButtonTap: () async {
                controller.processParameters(context,
                    (await context.push("/qrscanner")) as String?);
              },
              buttonTitle: L10n.of(context)!.scanQr,
              buttonState: ButtonState.idle,
            )
          ],
        ),
      ),
    );
  }
}


