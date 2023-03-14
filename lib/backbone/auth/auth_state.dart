import 'package:flutter/material.dart';
import 'package:nexus_wallet/backbone/auth/auth.dart';
import 'package:nexus_wallet/backbone/get_it.dart';
import 'package:nexus_wallet/backbone/helpers.dart';
import 'package:nexus_wallet/models/userwallet.dart';

import 'package:flutter/material.dart';

class BaseState extends ChangeNotifier {
  bool isLoading = false;

  setLoading(bool value) {
    isLoading = value;
    //important when i change something one should always notify the listeners this is why
    //implemented in basestate because he always simply said loading is true and notfiy listeners
    //and when they would change then loading would stop
    notifyListeners();
  }
}

class AuthenticationState extends BaseState {
  UserWallet? currentUser;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthenticationState() {
    if (currentUser == null) {
      _userNotifier();
    }
    Auth().currentUserNotifier.addListener(_userNotifier);
  }

  @override
  void dispose() {
    Auth().currentUserNotifier.removeListener(_userNotifier);
    super.dispose();
  }

  void _userNotifier() {
    currentUser = Auth().currentUserNotifier.value;
    notifyListeners();
  }
}