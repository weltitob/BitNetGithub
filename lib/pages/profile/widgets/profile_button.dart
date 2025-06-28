import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 30.0,
          height: 30.0,
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Icon(
              Icons.edit,
              size: 20.0,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
