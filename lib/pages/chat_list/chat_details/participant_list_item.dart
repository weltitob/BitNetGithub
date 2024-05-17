import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/user_bottom_sheet/user_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:matrix/matrix.dart';

import '../../../../components/container/avatar.dart';

class ParticipantListItem extends StatelessWidget {
  final User user;

  const ParticipantListItem(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membershipBatch = <Membership, String>{
      Membership.join: '',
      Membership.ban: L10n.of(context)!.banned,
      Membership.invite: L10n.of(context)!.invited,
      Membership.leave: L10n.of(context)!.leftTheChat,
    };
    final permissionBatch = user.powerLevel == 100
        ? L10n.of(context)!.admin
        : user.powerLevel >= 50
            ? L10n.of(context)!.moderator
            : '';

    return Opacity(
      opacity: user.membership == Membership.join ? 1 : 0.5,
      child: ListTile(
        onTap: () => BitNetBottomSheet(
          context: context,
          child: UserBottomSheet(
            user: user,
            outerContext: context,
          ),
        ),
        title: Row(
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Container(
                      height: AppTheme.elementSpacing * 1.5,
                      width: AppTheme.elementSpacing * 1.5,
                      child: Image.asset("assets/images/logoclean.png")),
                  SizedBox(width: AppTheme.elementSpacing / 2),
                  Container(
                    width: MediaQuery.of(context).size.width - AppTheme.cardPadding * 8.5,
                    child: Text(user.calcDisplayname(),
                      overflow: TextOverflow.ellipsis,),
                  ),
                ],
              ),
            ),
            if (permissionBatch.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.elementSpacing / 2,
                  vertical: AppTheme.elementSpacing / 6,
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing / 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: AppTheme.cardRadiusCircular,

                ),
                child: Text(
                  permissionBatch,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppTheme.white90,
                  ),
                ),
              ),
            membershipBatch[user.membership]!.isEmpty
                ? const SizedBox.shrink()
                : Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.symmetric(horizontal: AppTheme.elementSpacing / 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
                        Center(child: Text(membershipBatch[user.membership]!,
                        overflow: TextOverflow.ellipsis,)),
                  ),
          ],
        ),
        subtitle: Text(user.id, style: Theme.of(context).textTheme.bodyMedium,),
        leading: Avatar(
          mxContent: user.avatarUrl,
          name: user.calcDisplayname(),
          profileId: user.id,
        ),
      ),
    );
  }
}
