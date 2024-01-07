import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/platform_infos.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/textfieldbutton.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/add_content_bottom_sheet/add_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:animations/animations.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_shortcuts/keyboard_shortcuts.dart';
import 'package:matrix/matrix.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';
import '../../../chat_list/chat/chat.dart';
import 'input_bar.dart';

class ChatInputRow extends StatelessWidget {
  final ChatController controller;

  const ChatInputRow(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.showEmojiPicker &&
        controller.emojiPickerType == EmojiPickerType.reaction) {
      return const SizedBox.shrink();
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: controller.selectMode
          ? <Widget>[
              SizedBox(
                height: 56,
                child:
                Padding(
                  padding: const EdgeInsets.all(AppTheme.elementSpacing / 2),
                  child:
                  LongButtonWidget(
                    customWidth: AppTheme.cardPadding * 6,
                    customHeight: AppTheme.cardPadding * 2.5,
                    buttonType: ButtonType.transparent,
                    title: L10n.of(context)!.forward,
                    leadingIcon: Icon(
                      Icons.keyboard_arrow_left_outlined,
                      size: AppTheme.cardPadding,
                      color: AppTheme.white90,
                    ),
                    onTap: controller.forwardEventsAction,
                  ),
                ),
              ),
              controller.selectedEvents.length == 1
                  ? controller.selectedEvents.first
                          .getDisplayEvent(controller.timeline!)
                          .status
                          .isSent
                      ? SizedBox(
                          height: 56,
                          child: Padding(
                            padding: const EdgeInsets.all(AppTheme.elementSpacing / 2),
                            child:
                            LongButtonWidget(
                              customWidth: AppTheme.cardPadding * 6,
                              customHeight: AppTheme.cardPadding * 2.5,
                              buttonType: ButtonType.transparent,
                              title: L10n.of(context)!.reply,
                              leadingIcon: Icon(
                                Icons.keyboard_arrow_right,
                                size: AppTheme.cardPadding,
                                color: AppTheme.white90,
                              ),
                              onTap: controller.replyAction,
                            ),
                          ),


                          // TextButton(
                          //   onPressed: controller.replyAction,
                          //   child: Row(
                          //     children: <Widget>[
                          //       //Das hier zu einem meiner buttons machen
                          //       Text(L10n.of(context)!.reply, style: Theme.of(context).textTheme.titleSmall,),
                          //       const Icon(Icons.keyboard_arrow_right),
                          //     ],
                          //   ),
                          // ),
                        )
                      : SizedBox(
                          height: 56,
                          child: TextButton(
                            //auch das mein custom button
                            onPressed: controller.sendAgainAction,
                            child: Row(
                              children: <Widget>[
                                Text(L10n.of(context)!.tryToSendAgain),
                                const SizedBox(width: 4),
                                const Icon(Icons.send_outlined, size: 16),
                              ],
                            ),
                          ),
                        )
                  : const SizedBox.shrink(),
            ]
          : <Widget>[
              KeyBoardShortcuts(
                keysToPress: {
                  LogicalKeyboardKey.altLeft,
                  LogicalKeyboardKey.keyA
                },
                onKeysPressed: () => controller.onAddPopupMenuButtonSelected(MediaType.document),
                helpLabel: L10n.of(context)!.sendFile,
                child: AnimatedContainer(
                  duration: AppTheme.animationDuration,
                  curve: AppTheme.animationCurve,
                  height: 56,
                  width: controller.inputText.isEmpty ? 56 : 0,
                  alignment: Alignment.center,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(color: Colors.transparent), //
                  //controller.onAddPopupMenuButtonSelected,
                  child: TextFieldButtonMorph(
                    iconData: Icons.add_rounded,
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (builder) => AddContentWidget(controller: controller,));
                    },
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 56,
                alignment: Alignment.center,
                child: KeyBoardShortcuts(
                  keysToPress: {
                    LogicalKeyboardKey.altLeft,
                    LogicalKeyboardKey.keyE
                  },
                  onKeysPressed: controller.emojiPickerAction,
                  helpLabel: L10n.of(context)!.emojis,
                  child: IconButton(
                    tooltip: L10n.of(context)!.emojis,
                    icon: PageTransitionSwitcher(
                      transitionBuilder: (
                        Widget child,
                        Animation<double> primaryAnimation,
                        Animation<double> secondaryAnimation,
                      ) {
                        return SharedAxisTransition(
                          animation: primaryAnimation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.scaled,
                          fillColor: Colors.transparent,
                          child: child,
                        );
                      },
                      child: Icon(
                        controller.showEmojiPicker
                            ? Icons.keyboard
                            : Icons.emoji_emotions_outlined,
                        key: ValueKey(controller.showEmojiPicker),
                      ),
                    ),
                    onPressed: controller.emojiPickerAction,
                  ),
                ),
              ),
              if (Matrix.of(context).isMultiAccount &&
                  Matrix.of(context).hasComplexBundles &&
                  Matrix.of(context).currentBundle!.length > 1)
                Container(
                  height: 56,
                  alignment: Alignment.center,
                  child: _ChatAccountPicker(controller),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: InputBar(
                    room: controller.room,
                    minLines: 1,
                    maxLines: 8,
                    autofocus: !PlatformInfos.isMobile,
                    keyboardType: TextInputType.multiline,
                    textInputAction:
                        AppTheme.sendOnEnter ? TextInputAction.send : null,
                    onSubmitted: controller.onInputBarSubmitted,
                    focusNode: controller.inputFocus,
                    controller: controller.sendController,
                    decoration: InputDecoration(
                      //fillColor: Colors.brown,
                      //focusColor: Colors.red,
                      hintText: L10n.of(context)!.writeAMessage,
                      hintMaxLines: 1,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      filled: false,
                    ),
                    onChanged: controller.onInputBarChanged,
                  ),
                ),
              ),
              if (PlatformInfos.platformCanRecord &&
                  controller.inputText.isEmpty)
                Container(
                  color: Colors.transparent,
                  height: 56,
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(right: AppTheme.elementSpacing / 2),
                    decoration: BoxDecoration(
                      color: //recorder.isRecording
                          //? AppTheme.errorColor
                          //      :
                          Theme.of(context).colorScheme.onSecondary,
                      borderRadius: AppTheme.cardRadiusCircular,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.elementSpacing / 1.5),
                      child: Icon(
                          // commentController.text.isEmpty
                          //     ? recorder.isRecording
                          //         ? Icons.stop_rounded
                          //         : Icons.mic_rounded
                          //   :
                          Icons.mic_rounded,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),

                  // IconButton(
                  //   tooltip: L10n.of(context)!.voiceMessage,
                  //   icon: const Icon(Icons.mic_none_outlined),
                  //   onPressed: controller.voiceMessageAction,
                  // ),
                ),
              if (!PlatformInfos.isMobile || controller.inputText.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    print("Controller send should be triggered.");
                    controller.send();
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: 56,
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(right: AppTheme.elementSpacing / 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSecondary,
                        borderRadius: AppTheme.cardRadiusCircular,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppTheme.elementSpacing / 1.5),
                        child: Icon(
                            FontAwesomeIcons.arrowUp,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ),
            ],
    );
  }
}

class _ChatAccountPicker extends StatelessWidget {
  final ChatController controller;

  const _ChatAccountPicker(this.controller, {Key? key}) : super(key: key);

  void _popupMenuButtonSelected(String mxid, BuildContext context) {
    final client = Matrix.of(context)
        .currentBundle!
        .firstWhere((cl) => cl!.userID == mxid, orElse: () => null);
    if (client == null) {
      Logs().w('Attempted to switch to a non-existing client $mxid');
      return;
    }
    controller.setSendingClient(client);
  }

  @override
  Widget build(BuildContext context) {
    final clients = controller.currentRoomBundle;
    return Padding(
      padding: const EdgeInsets.all(AppTheme.elementSpacing / 2),
      child: FutureBuilder<Profile>(
        future: controller.sendingClient.fetchOwnProfile(),
        builder: (context, snapshot) => PopupMenuButton<String>(
          onSelected: (mxid) => _popupMenuButtonSelected(mxid, context),
          itemBuilder: (BuildContext context) => clients
              .map(
                (client) => PopupMenuItem<String>(
                  value: client!.userID,
                  child: FutureBuilder<Profile>(
                    future: client.fetchOwnProfile(),
                    builder: (context, snapshot) => ListTile(
                      leading: Avatar(
                        mxContent: snapshot.data?.avatarUrl,
                        name: snapshot.data?.displayName ??
                            client.userID!.localpart,
                        size: AppTheme.cardPadding,
                      ),
                      title: Text(snapshot.data?.displayName ?? client.userID!),
                      contentPadding: const EdgeInsets.all(0),
                    ),
                  ),
                ),
              )
              .toList(),
          child: Avatar(
            mxContent: snapshot.data?.avatarUrl,
            name: snapshot.data?.displayName ??
                Matrix.of(context).client.userID!.localpart,
            size: AppTheme.cardPadding,
          ),
        ),
      ),
    );
  }
}
