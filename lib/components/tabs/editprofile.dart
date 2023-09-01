
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

class EditProfileTab extends StatefulWidget {
  const EditProfileTab({Key? key}) : super(key: key);

  @override
  State<EditProfileTab> createState() => _EditProfileTabState();
}

class _EditProfileTabState extends State<EditProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppTheme.cardPadding,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Private Profile:", style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(width: AppTheme.cardPadding,),
              Switcher(
                value: false,
                size: SwitcherSize.medium,
                switcherButtonRadius: 50,
                enabledSwitcherButtonRotate: true,
                iconOff: Icons.lock_open_rounded,
                iconOn: Icons.lock,
                colorOff: Theme.of(context).colorScheme.secondary,
                colorOn: Theme.of(context).colorScheme.primary,
                onChanged: (bool state) {
                },
              ),
            ],
          ),
          SizedBox(height: AppTheme.cardPadding,),
          Text("Unchangeable Profile information:",
            style: Theme.of(context).textTheme.subtitle1,),
          SizedBox(height: AppTheme.elementSpacing,),
          Text("WalletAdress: Brrjflakjasdkaskldajkdklajdlka",
            style: Theme.of(context).textTheme.bodyText2,),
          SizedBox(height: AppTheme.elementSpacing / 2,),
          Text("Did: 290891280937810237812897310923890",
            style: Theme.of(context).textTheme.bodyText2,),
          SizedBox(height: AppTheme.cardPadding,),
          // Center(
          //   child: LongButtonWidget(
          //     title: "Save changes",
          //     onTap: () {
          //       print("Saved changes");
          //     },
          //     buttonColor: Theme.of(context).colorScheme.primaryContainer,
          //     textColor: Theme.of(context).colorScheme.onPrimaryContainer,
          //   ),
          // ),
        ],
      ),
    );
  }
}
