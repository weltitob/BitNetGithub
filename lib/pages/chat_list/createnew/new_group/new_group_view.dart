import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/pages/chat_list/createnew/new_group/new_group.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/l10n.dart';

class NewGroupView extends StatelessWidget {
  final NewGroupController controller;

  const NewGroupView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: AppTheme.cardPadding * 2,
        ),
        Stack(
          children: [
            Material(
              elevation:
                  Theme.of(context).appBarTheme.scrolledUnderElevation ?? 4,
              shadowColor: Theme.of(context).appBarTheme.shadowColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
                borderRadius: BorderRadius.circular(
                  Avatar.defaultSize,
                ),
              ),
              child: Avatar(
                size: Avatar.defaultSize * 2.5,
                fontSize: 18 * 2.5,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: FloatingActionButton.small(
                onPressed: () {},
                heroTag: null,
                child: const Icon(Icons.camera_alt_outlined),
              ),
            ),
          ],
        ),
        SizedBox(
          height: AppTheme.cardPadding,
        ),
        Padding(
            padding: const EdgeInsets.all(AppTheme.cardPadding),
            child: FormTextField(
              hintText: L10n.of(context)!.optionalGroupName,
              isObscure: false,
              controller: controller.controller,
              textInputAction: TextInputAction.go,
            )),
        Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: FormTextField(
              hintText: L10n.of(context)!.groupDescription,
              isObscure: false,
              controller: controller.controller,
              textInputAction: TextInputAction.go,
            )),
        SwitchListTile.adaptive(
          secondary: const Icon(Icons.public_outlined),
          title: Text(L10n.of(context)!.groupIsPublic),
          value: controller.publicGroup,
          onChanged: controller.setPublicGroup,
        ),
        // SwitchListTile.adaptive(
        //   secondary: const Icon(Icons.lock_outlined),
        //   title: Text(L10n.of(context)!.enableEncryption),
        //   value: !controller.publicGroup,
        //   onChanged: null,
        // ),
        LongButtonWidget(
          title: 'Next',
          onTap: controller.submitAction,
        )
      ],
    );
  }
}
