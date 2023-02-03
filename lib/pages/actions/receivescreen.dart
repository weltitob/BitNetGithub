import 'package:flutter/material.dart';
import 'package:nexus_wallet/components/buttons/glassbutton.dart';
import 'package:nexus_wallet/theme.dart';

class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.copy_rounded,
                size: 18,
                color: AppTheme.white60,
              ),
              const SizedBox(
                width: AppTheme.elementSpacing * 0.25,),
              Text(
                "3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy",
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium,
              ),
            ],
          ),
          const SizedBox(
            height: AppTheme.cardPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              glassButton("Copy", Icons.copy_rounded, () => null),
              glassButton(
                  "Share", Icons.share_rounded, () => null),
              glassButton("Keys", Icons.key_rounded, () => null)
            ],
          ),
        ],
      ),
    );
  }
}