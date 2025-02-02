import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:flutter/material.dart';

class EditProfileTab extends StatefulWidget {
  const EditProfileTab({Key? key}) : super(key: key);

  @override
  State<EditProfileTab> createState() => _EditProfileTabState();
}

class _EditProfileTabState extends State<EditProfileTab> {
  bool _isPrivate = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppTheme.cardPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Private Profile:",
                    style: Theme.of(context).textTheme.titleMedium),
                Switch(
                  value: _isPrivate,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (bool value) {
                    setState(() {
                      _isPrivate = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: AppTheme.cardPadding),
            Text("Unchangeable Profile information:",
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppTheme.elementSpacing),
            Text("Wallet Address: ...",
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppTheme.elementSpacing / 2),
            Text("Did: ${Auth().currentUser!.uid}",
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppTheme.cardPadding),
          ],
        ),
      ),
    );
  }
}
