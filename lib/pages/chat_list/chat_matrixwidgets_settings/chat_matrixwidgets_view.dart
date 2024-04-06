import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/chat_list/chat_matrixwidgets_settings/chat_matrixwidgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';


class ChatMatrixWidgetsView extends StatelessWidget {
  final ChatMatrixWidgetController controller;

  const ChatMatrixWidgetsView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return bitnetScaffold(
      context: context,
      appBar: bitnetAppBar(
        onTap: () => context.pop(),
        context: context,
        text: L10n.of(context)!.editWidgets,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ...controller.room.widgets.map(
            (e) => BitNetListTile(
              text: e.name ?? e.type,
              leading: IconButton(
                onPressed: () {
                  controller.room.deleteWidget(e.id!);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          ),
          Column(
            children: [
              BitNetListTile(
                text: L10n.of(context)!.addWidget,
                leading: const Icon(Icons.add),
              ),
              //hier dieselbe kontrolle wie beim create screen und chatview vom design
              SizedBox(
                height: AppTheme.cardPadding,
              ),
              //controller.setWidgetType,
              Container(
                margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BitNetImageWithTextContainer(
                            height: AppTheme.cardPadding * 4,
                            width: AppTheme.cardPadding * 4,
                            L10n.of(context)!.widgetEtherpad,
                            isActive: controller.widgetType == 'm.etherpad',
                            image: "assets/images/etherpad.png", () {
                          controller.setWidgetType('m.etherpad');
                        }),
                        BitNetImageWithTextContainer(L10n.of(context)!.widgetJitsi,
                            height: AppTheme.cardPadding * 4,
                            width: AppTheme.cardPadding * 4,
                            isActive: controller.widgetType == 'm.jitsi',
                            image: "assets/images/jitsi.png", () {
                          controller.setWidgetType('m.jitsi');
                        }),
                        BitNetImageWithTextContainer(L10n.of(context)!.widgetVideo,
                            height: AppTheme.cardPadding * 4,
                            width: AppTheme.cardPadding * 4,
                            isActive: controller.widgetType == 'm.video',
                            image: "assets/images/video.png", () {
                          controller.setWidgetType('m.video');
                        }),
                        BitNetImageWithTextContainer(L10n.of(context)!.widgetCustom,
                            height: AppTheme.cardPadding * 4,
                            width: AppTheme.cardPadding * 4,
                            isActive: controller.widgetType == 'm.custom',
                            image: "assets/images/custom.png", () {
                          controller.setWidgetType('m.custom');
                        })
                      ],
                    ),
                    SizedBox(
                      height: AppTheme.cardPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding,
              ),
              //eigene textfields wie bei create screen
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding),
                child: FormTextField(
                  controller: controller.nameController,
                  labelText: L10n.of(context)!.widgetName,
                  hintText: L10n.of(context)!.widgetName,
                  //prefixIcon: const Icon(Icons.label),
                  //errorText: controller.nameError,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.cardPadding),
                child: FormTextField(
                  hintText: L10n.of(context)!.link,
                  controller: controller.urlController,
                  //errortext: controller.urlError,
                  //prefixIcon: const Icon(Icons.add_link),
                  labelText: L10n.of(context)!.link,
                  isObscure: false,
                ),
              ),
              SizedBox(
                height: AppTheme.cardPadding,
              ),
              LongButtonWidget(
                buttonType: ButtonType.transparent,
                customHeight: AppTheme.cardPadding * 2,
                customWidth: AppTheme.cardPadding * 8,
                onTap: controller.addWidget,
                title: L10n.of(context)!.addWidget,
              )
            ],
          ),
        ],
      )),
    );
  }
}
