import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/appstandards/glasscontainer.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/buttons/bottom_buybuttons.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/models/user/userdata.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class UserResult extends StatefulWidget {
  final UserData userData;
  final dynamic onTap;
  final VoidCallback onDelete;
  final IconData? onTapIcon;
  final bool selected;
  final bool obscureUsername;
  final bool invited;
  //0 not yet, 1 no, 2 yes
  final int acceptedInvite;
  //to not have duplicate classes, this widget will have models, model 0 will be the x and the key icon,
  // model 1 will be invite icon alone
  //model 2 will have 0 icons
  //model 3 signifies the account no longer exists
  //model 4 has two icons, send invitation, and key
  final int model;
  const UserResult({
    required this.userData,
    required this.onTap,
    required this.onDelete,
    this.onTapIcon,
    this.model = 0,
    this.obscureUsername = false,
    this.invited = false,
    this.acceptedInvite = 0,
    this.selected = false,
  });

  @override
  State<UserResult> createState() => _UserResultState();
}

class _UserResultState extends State<UserResult> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.cardPadding * 2.75,
      child: GlassContainer(
        border: Border.all(
            width: 1.5,
            color:
                Theme.of(context).dividerColor), // remove border if not active
        opacity: 0.1,
        borderRadius: AppTheme.cardPadding * 2.75 / 3,
        child: InkWell(
          onTap: widget.model == 2 ? widget.onTap : () {},
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusBig),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: AppTheme.elementSpacing,
                  ),
                  Avatar(
                      profileId: widget.userData.did,
                      mxContent: Uri.parse(widget.userData.profileImageUrl),
                      size: AppTheme.cardPadding * 1.75,
                      onTap: widget.onTap,
                      isNft: widget.userData.nft_profile_id.isNotEmpty),
                  const SizedBox(width: AppTheme.elementSpacing),
                  Container(
                    width: AppTheme.cardPadding * 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.obscureUsername
                              ? "@${widget.userData.username.substring(0, 3)}***"
                              : "@${widget.userData.username}",
                          style: Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.model == 3
                              ? 'this account no longer exists...'
                              : widget.userData.did,
                          style: widget.model == 3
                              ? Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppTheme.errorColor)
                              : Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: _loading
                    ? [
                        dotProgress(context),
                        const SizedBox(
                          width: AppTheme.cardPadding,
                        )
                      ]
                    : [
                        if (widget.model == 0) ...[
                          InkWell(
                            onTap: () {
                              BitNetBottomSheet(
                                context: context,
                                height: AppTheme.cardPadding * 16,
                                child: Column(
                                  children: [
                                    // Content area with padding
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            AppTheme.cardPadding),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Header with icon and title
                                            Container(
                                              height: AppTheme.cardPadding * 3,
                                              width: AppTheme.cardPadding * 3,
                                              decoration: BoxDecoration(
                                                color: AppTheme.errorColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppTheme.cardPadding *
                                                            1.5),
                                              ),
                                              child: Icon(
                                                FontAwesomeIcons.trash,
                                                color: AppTheme.errorColor,
                                                size:
                                                    AppTheme.cardPadding * 1.2,
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    AppTheme.elementSpacing),
                                            Text(
                                              'Delete saved account from device?',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(
                                                height:
                                                    AppTheme.elementSpacing /
                                                        2),
                                            Text(
                                              'This will remove the account from this device. You can still recover it later using your mnemonic phrase.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.color
                                                        ?.withOpacity(0.7),
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Bottom buttons with no additional padding
                                    BottomButtons(
                                      leftButtonTitle: 'Cancel',
                                      rightButtonTitle: 'Delete',
                                      onLeftButtonTap: () =>
                                          Navigator.of(context).pop(),
                                      onRightButtonTap: () {
                                        Navigator.of(context).pop();
                                        widget.onDelete();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              height: AppTheme.cardPadding * 1.5,
                              width: AppTheme.cardPadding * 1.5,
                              child: GlassContainer(
                                border: Border.all(
                                    width: 1.5,
                                    color: Theme.of(context)
                                        .dividerColor), // remove border if not active
                                opacity: 0.1,
                                borderRadius: BorderRadius.circular(
                                    AppTheme.borderRadiusMid),
                                child: Icon(
                                  FontAwesomeIcons.remove,
                                  size: AppTheme.elementSpacing * 1.5,
                                  color: AppTheme.white70,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.elementSpacing),
                            child: InkWell(
                              onTap: () async {
                                final logger = Get.find<LoggerService>();
                                logger.i(
                                    "Login for user ${widget.userData.did} pressed");
                                setState(() {
                                  _loading = true;
                                  logger.i("Loading set to true");
                                });
                                try {
                                  await widget.onTap();
                                } catch (e) {
                                  print(e);
                                } finally {
                                  setState(() {
                                    _loading = false;
                                  });
                                }
                              },
                              child: Container(
                                height: AppTheme.cardPadding * 1.5,
                                width: AppTheme.cardPadding * 1.5,
                                child: GlassContainer(
                                  border: Border.all(
                                      width: 1.5,
                                      color: Theme.of(context)
                                          .dividerColor), // remove border if not active
                                  opacity: 0.1,
                                  borderRadius: BorderRadius.circular(
                                      AppTheme.borderRadiusCircular),
                                  child: Icon(
                                    FontAwesomeIcons.key,
                                    size: AppTheme.elementSpacing * 1.5,
                                    color: AppTheme.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        if (widget.model == 1) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.elementSpacing),
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  _loading = true;
                                });
                                try {
                                  await widget.onTap();
                                } catch (e) {
                                  print(e);
                                } finally {
                                  setState(() {
                                    _loading = false;
                                  });
                                }
                              },
                              child: Container(
                                height: AppTheme.cardPadding * 1.5,
                                width: AppTheme.cardPadding * 1.5,
                                child: GlassContainer(
                                  border: Border.all(
                                      width: 1.5,
                                      color: Theme.of(context)
                                          .dividerColor), // remove border if not active
                                  opacity: 0.1,
                                  borderRadius: BorderRadius.circular(
                                      AppTheme.borderRadiusCircular),
                                  child: Icon(
                                    widget.onTapIcon ?? Icons.person_add,
                                    size: AppTheme.elementSpacing * 1.5,
                                    color: AppTheme.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        if (widget.model == 4) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.elementSpacing),
                            child: InkWell(
                              onTap: () async {},
                              child: Container(
                                height: AppTheme.cardPadding * 1.5,
                                width: AppTheme.cardPadding * 1.5,
                                child: GlassContainer(
                                  border: Border.all(
                                      width: 1.5,
                                      color: Theme.of(context)
                                          .dividerColor), // remove border if not active
                                  opacity: 0.1,
                                  borderRadius: BorderRadius.circular(
                                      AppTheme.borderRadiusCircular),
                                  child: Icon(
                                    FontAwesomeIcons.key,
                                    size: AppTheme.elementSpacing * 1.5,
                                    color: widget.acceptedInvite == 1
                                        ? AppTheme.errorColor
                                        : widget.acceptedInvite == 2
                                            ? AppTheme.successColor
                                            : AppTheme.white70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                      ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
