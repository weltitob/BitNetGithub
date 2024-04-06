import 'package:bitnet/backbone/helper/matrix_helpers/matrix_sdk_extensions/matrix_locals.dart';
import 'package:bitnet/backbone/helper/matrix_helpers/url_launcher.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetListTile.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/appstandards/optioncontainer.dart';
import 'package:bitnet/components/dialogsandsheets/dialogs/dialogs.dart';
import 'package:bitnet/pages/chat_list/chat_details/chat_details.dart';
import 'package:bitnet/pages/chat_list/chat_details/participant_list_item.dart';
import 'package:bitnet/backbone/helper/social_share.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart';

import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/pages/routetrees/matrix.dart';

class ChatDetailsView extends StatelessWidget {
  final ChatDetailsController controller;
  final GoRouterState routerState;

  const ChatDetailsView(this.controller, {Key? key, required this.routerState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final room = Matrix.of(context).client.getRoomById(controller.roomId!);

    if (room == null) {
      return bitnetScaffold(
        extendBodyBehindAppBar: true,
        appBar: bitnetAppBar(
          onTap: () => context.go('rooms'),
            context: context, text: L10n.of(context)!.oopsSomethingWentWrong),
        body: Center(
          child: Text(L10n.of(context)!.youAreNoLongerParticipatingInThisChat),
        ),
        context: context,
      );
    }

    controller.members!.removeWhere((u) => u.membership == Membership.leave);
    final actualMembersCount = (room.summary.mInvitedMemberCount ?? 0) +
        (room.summary.mJoinedMemberCount ?? 0);
    final canRequestMoreMembers =
        controller.members!.length < actualMembersCount;

    final iconColor = Theme.of(context).textTheme.bodyLarge!.color;

    return bitnetScaffold(
      context: context,
      extendBodyBehindAppBar: true,
      appBar: bitnetAppBar(
        onTap: () => (routerState.path != null && routerState.path!.startsWith('/spaces/'))
            ? context.pop()
            : context.goNamed('rooms', pathParameters: {'roomid': controller.roomId!}),
        text: "Group Info",
        context: context,
      ),
      body: StreamBuilder<Object>(
          stream: room.onUpdate.stream,
          builder: (context, snapshot) {
            final String memberCount = actualMembersCount > 1
                ? L10n.of(context)!.countParticipants(
                    actualMembersCount.toString(),
                  )
                : L10n.of(context)!.emptyChat;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.members!.length +
                  1 +
                  (canRequestMoreMembers ? 1 : 0),
              itemBuilder: (BuildContext context, int i) => i == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //   flexibleSpace: FlexibleSpaceBar(
                        //     background: ContentBanner(
                        //       mxContent: room.avatar,
                        //       onEdit: room.canSendEvent('m.room.avatar')
                        //           ? controller.setAvatarAction
                        //           : null,
                        //       defaultIcon: Icons.group_outlined,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: AppTheme.cardPadding),
                        Center(
                          child: Avatar(
                            size: AppTheme.cardPadding * 6,
                            mxContent: room.avatar,
                            name: room.getLocalizedDisplayname(
                              MatrixLocals(L10n.of(context)!),
                            ),
                            profileId: room.id,
                          ),
                        ),
                        const SizedBox(height: AppTheme.cardPadding),
                        Center(
                          child: Text(
                            room.getLocalizedDisplayname(
                              MatrixLocals(L10n.of(context)!),
                            ),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        const SizedBox(
                          height: AppTheme.elementSpacing,
                        ),
                        Center(
                          child: Text(
                            "Group  " + "•  " + memberCount,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(
                          height: AppTheme.elementSpacing,
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: AppTheme.elementSpacing),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (room.canInvite)
                                BitNetImageWithTextContainer(
                                  L10n.of(context)!.inviteContact,
                                  () {
                                    context.go(GoRouter.of(context).routerDelegate.currentConfiguration.fullPath + '/invite');
                                  },
                                  isActive: true,
                                  image: "assets/images/iphone.png",
                                  height: AppTheme.cardPadding * 3.5,
                                  width: AppTheme.cardPadding * 3.5,
                                ),
                              room.pushRuleState == PushRuleState.notify
                                  ? BitNetImageWithTextContainer(
                                      L10n.of(context)!.muteChat,
                                      () {
                                        Logs().w("pressed Mute button");
                                        controller.muteroom(room);
                                      },
                                      image: "assets/images/darkmode.png",
                                      height: AppTheme.cardPadding * 3.5,
                                      width: AppTheme.cardPadding * 3.5,
                                      isActive: true,
                                    )
                                  : BitNetImageWithTextContainer(
                                      L10n.of(context)!.unmuteChat,
                                      () {
                                        controller.unmuteroom(room);
                                      },
                                      image: "assets/images/lightmode.png",
                                      height: AppTheme.cardPadding * 3.5,
                                      width: AppTheme.cardPadding * 3.5,
                                      isActive: true,
                                    ),
                              if (room.canonicalAlias.isNotEmpty)
                                BitNetImageWithTextContainer(
                                  L10n.of(context)!.share,
                                  () {
                                    SocialShare.share(
                                      AppTheme.inviteLinkPrefix +
                                          room.canonicalAlias,
                                      context,
                                    );
                                  },
                                  image: "assets/images/bitcoin.png",
                                  height: AppTheme.cardPadding * 3.5,
                                  width: AppTheme.cardPadding * 3.5,
                                  isActive: true,
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppTheme.cardPadding),
                        BitNetListTile(
                          onTap: room.canSendEvent(EventTypes.RoomTopic)
                              ? controller.setTopicAction
                              : null,
                          trailing: room.canSendEvent(EventTypes.RoomTopic)
                              ? Icon(
                                  Icons.edit_outlined,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                )
                              : null,
                          text: L10n.of(context)!.groupDescription,
                        ),
                        if (room.topic.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.elementSpacing * 1.5,
                            ),
                            child: Linkify(
                              text: room.topic.isEmpty
                                  ? L10n.of(context)!.addGroupDescription
                                  : room.topic,
                              options: const LinkifyOptions(humanize: false),
                              linkStyle:
                                  const TextStyle(color: AppTheme.colorLink),
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .fontSize,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                                decorationColor: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                              ),
                              onOpen: (url) =>
                                  UrlLauncher(context, url.url).launchUrl(),
                            ),
                          ),
                        const SizedBox(height: AppTheme.elementSpacing),
                        BitNetListTile(
                          text: L10n.of(context)!.settings,
                          trailing: Icon(
                            controller.displaySettings
                                ? Icons.keyboard_arrow_down_outlined
                                : Icons.keyboard_arrow_right_outlined,
                          ),
                          onTap: controller.toggleDisplaySettings,
                        ),
                        const SizedBox(height: AppTheme.elementSpacing),
                        if (controller.displaySettings) ...[
                          if (room.canSendEvent('m.room.name'))
                            BitNetListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                foregroundColor: iconColor,
                                child: const Icon(
                                  Icons.people_outline_outlined,
                                ),
                              ),
                              text: L10n.of(context)!.changeTheNameOfTheGroup,
                              subtitle: Text(
                                room.getLocalizedDisplayname(
                                  MatrixLocals(L10n.of(context)!),
                                ),
                              ),
                              onTap: controller.setDisplaynameAction,
                            ),
                          if (room.joinRules == JoinRules.public)
                            BitNetListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                foregroundColor: iconColor,
                                child: const Icon(Icons.link_outlined),
                              ),
                              onTap: controller.editAliases,
                              text: L10n.of(context)!.editRoomAliases,
                              subtitle: Text(
                                (room.canonicalAlias.isNotEmpty)
                                    ? room.canonicalAlias
                                    : L10n.of(context)!.none,
                              ),
                            ),
                          BitNetListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              foregroundColor: iconColor,
                              child: const Icon(
                                Icons.insert_emoticon_outlined,
                              ),
                            ),
                            text: L10n.of(context)!.emoteSettings,
                            subtitle: Text(L10n.of(context)!.setCustomEmotes),
                            onTap: controller.goToEmoteSettings,
                          ),
                          BitNetListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              foregroundColor: iconColor,
                              child: const Icon(Icons.shield_outlined),
                            ),
                            text: L10n.of(context)!.whoIsAllowedToJoinThisGroup,
                            subtitle: Text(
                              room.joinRules?.getLocalizedString(
                                    MatrixLocals(L10n.of(context)!),
                                  ) ??
                                  L10n.of(context)!.none,
                            ),
                            onTap: () {
                              if (room.canChangeGuestAccess)
                                showDialogueMultipleOptions(context: context,
                                title: L10n.of(context)!.whoIsAllowedToJoinThisGroup,
                                images: [
                                  "assets/images/friends.png",
                                  "assets/images/friends.png",
                                ],
                                texts: [
                                  GuestAccess.canJoin.getLocalizedString(
                                    MatrixLocals(L10n.of(context)!),
                                  ),
                                  GuestAccess.forbidden.getLocalizedString(
                                    MatrixLocals(L10n.of(context)!),
                                  ),
                                ],
                                  actions: [
                                    () {
                                        controller.setGuestAccessAction(
                                            GuestAccess.canJoin);
                                      },
                                          () {
                                        controller.setGuestAccessAction(
                                            GuestAccess.forbidden);
                                      },
                                    ],
                                    isActives: [
                                      GuestAccess == GuestAccess.canJoin,
                                      GuestAccess == GuestAccess.forbidden,
                                    ],
                                );

                            },
                          ),
                          BitNetListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              foregroundColor: iconColor,
                              child: const Icon(Icons.visibility_outlined),
                            ),
                            text: L10n.of(context)!.visibilityOfTheChatHistory,
                            subtitle: Text(
                              room.historyVisibility?.getLocalizedString(
                                    MatrixLocals(L10n.of(context)!),
                                  ) ??
                                  L10n.of(context)!.none,
                            ),
                            onTap: () {
                              if (room.canChangeHistoryVisibility)
                                showDialogueMultipleOptions(
                                  isActives: [
                                    HistoryVisibility == HistoryVisibility.invited,
                                    HistoryVisibility == HistoryVisibility.joined,
                                    HistoryVisibility == HistoryVisibility.shared,
                                    HistoryVisibility == HistoryVisibility.worldReadable,
                                  ],
                                  title: L10n.of(context)!
                                      .visibilityOfTheChatHistory,
                                    context: context,
                                    images: [
                                      "assets/images/friends.png",
                                      "assets/images/friends.png",
                                      "assets/images/friends.png",
                                      "assets/images/friends.png",
                                    ],
                                    texts: [
                                      HistoryVisibility.invited
                                          .getLocalizedString(
                                        MatrixLocals(
                                            L10n.of(context)!),
                                      ),
                                      HistoryVisibility.joined
                                          .getLocalizedString(
                                        MatrixLocals(
                                            L10n.of(context)!),
                                      ),
                                      HistoryVisibility.shared
                                          .getLocalizedString(
                                        MatrixLocals(
                                            L10n.of(context)!),
                                      ),
                                      HistoryVisibility.worldReadable
                                          .getLocalizedString(
                                        MatrixLocals(
                                            L10n.of(context)!),
                                      ),
                                    ],
                                    actions: [
                                      () {
                                        controller
                                            .setHistoryVisibilityAction(
                                            HistoryVisibility
                                                .invited);
                                      },
                                      () {
                                        controller
                                            .setHistoryVisibilityAction(
                                            HistoryVisibility
                                                .joined);
                                      },
                                      () {
                                        controller
                                            .setHistoryVisibilityAction(
                                            HistoryVisibility
                                                .shared);
                                      },
                                      () {
                                        controller
                                            .setHistoryVisibilityAction(
                                            HistoryVisibility
                                                .worldReadable);
                                      },
                                    ],
                              );
                            },
                          ),
                          if (room.joinRules == JoinRules.public)
                            BitNetListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                foregroundColor: iconColor,
                                child: const Icon(
                                  Icons.person_add_alt_1_outlined,
                                ),
                              ),
                              text: L10n.of(context)!.areGuestsAllowedToJoin,
                              subtitle: Text(
                                room.guestAccess.getLocalizedString(
                                  MatrixLocals(L10n.of(context)!),
                                ),
                              ),
                              onTap: () {
                                if (room.canChangeJoinRules)
                                  showDialogueMultipleOptions(context: context,
                                  title: L10n.of(context)!.areGuestsAllowedToJoin,
                                  images: [
                                    "assets/images/friends.png",
                                    "assets/images/friends.png",
                                  ],
                                  texts: [
                                    JoinRules.public.getLocalizedString(
                                      MatrixLocals(L10n.of(context)!),
                                    ),
                                    JoinRules.invite.getLocalizedString(
                                      MatrixLocals(L10n.of(context)!),
                                    ),
                                  ],
                                    actions: [
                                          () {
                                        controller.setJoinRulesAction(
                                            JoinRules.public);
                                      },
                                          () {
                                        controller.setJoinRulesAction(
                                            JoinRules.invite);
                                      },
                                    ],
                                    isActives: [
                                      JoinRules == JoinRules.public,
                                      JoinRules == JoinRules.invite,
                                    ],
                                  );
                              },
                            ),
                          BitNetListTile(
                            text: L10n.of(context)!.editChatPermissions,
                            subtitle: Text(
                              L10n.of(context)!.whoCanPerformWhichAction,
                            ),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              foregroundColor: iconColor,
                              child: const Icon(
                                Icons.edit_attributes_outlined,
                              ),
                            ),
                            onTap: () => context.go(GoRouter.of(context).routerDelegate.currentConfiguration.fullPath + '/permissions'),
                          ),
                          BitNetListTile(
                            text: L10n.of(context)!.matrixWidgets,
                            subtitle: Text(L10n.of(context)!.editWidgets),
                            onTap: () => context.go(GoRouter.of(context).routerDelegate.currentConfiguration.fullPath + '/widgets'), //controller.showWidgets(room),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: const Icon(
                                Icons.widgets_outlined,
                              ),
                            ),
                          ),
                          BitNetListTile(
                            titleStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppTheme.errorColor,
                                ),
                            text: "Leave group",
                            leading: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: const Icon(
                                Icons.login_rounded,
                                color: AppTheme.errorColor,
                              ),
                            ),
                            onTap: () => controller.leaveSpace(room),
                          ),
                          const SizedBox(height: AppTheme.elementSpacing),
                        ],
                        BitNetListTile(
                          text: memberCount,
                          trailing: memberCount != L10n.of(context)!.emptyChat
                              ? Icon(
                                  Icons.search,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                )
                              : null,
                        ),
                        // room.canInvite
                        //     ? Column(
                        //       children: [
                        //         Container(
                        //           child: BitNetListTile(
                        //               text: L10n.of(context)!.inviteContact,
                        //               leading: CircleAvatar(
                        //                 backgroundColor: AppTheme.colorBitcoin,
                        //                 foregroundColor: Colors.white,
                        //                 radius: Avatar.defaultSize / 2,
                        //                 child: const Icon(Icons.add),
                        //               ),
                        //               onTap: () => context.go('invite'),
                        //             ),
                        //         ),
                        //         Container(
                        //           child: BitNetListTile(
                        //             text: L10n.of(context)!.shareYourInviteLink,
                        //             leading: CircleAvatar(
                        //               backgroundColor: AppTheme.colorBitcoin,
                        //               foregroundColor: Colors.white,
                        //               radius:  Avatar.defaultSize / 2,
                        //               child: const Icon(Icons.link_rounded),
                        //             ),
                        //             onTap: () => context.go('invite'),
                        //           ),
                        //         )
                        //       ],
                        //     )
                        //     : const SizedBox.shrink(),
                      ],
                    )
                  : i < controller.members!.length + 1
                      ? ParticipantListItem(controller.members![i - 1])
                      : BitNetListTile(
                          text: L10n.of(context)!.loadCountMoreParticipants(
                            (actualMembersCount - controller.members!.length)
                                .toString(),
                          ),
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: const Icon(
                              Icons.refresh,
                              color: Colors.grey,
                            ),
                          ),
                          onTap: controller.requestMoreMembersAction,
                        ),

            );
          }),
    );
  }
}
