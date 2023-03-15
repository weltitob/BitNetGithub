import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/get_it.dart';
import 'package:nexus_wallet/backbone/helpers.dart';
import 'package:nexus_wallet/models/userwallet.dart';

import 'package:flutter/material.dart';

class AuthenticationState extends ChangeNotifier {
  UserWallet? currentUser;
  final userRepo = locate<Auth>();

  AuthenticationState() {
    print("Authentication State triggered");
    if (currentUser == null) {
      _userNotifier();
    }
    userRepo.currentUserNotifier.addListener(_userNotifier);
    print('Authentication State should have added a listener now');
  }

  @override
  void dispose() {
    print('Authentication State dispose triggered');
    userRepo.currentUserNotifier.removeListener(_userNotifier);
    super.dispose();
  }

  void _userNotifier() {
    print('Authentication State _userNotifier triggered');
    currentUser = userRepo.currentUserNotifier.value;
    print("_userNotifier: ${userRepo.currentUserNotifier.value}");
    notifyListeners();
  }
}