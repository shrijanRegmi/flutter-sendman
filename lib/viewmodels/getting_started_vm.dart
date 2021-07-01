import 'package:flutter/material.dart';
import 'package:send_man/services/auth/auth_provider.dart';

class GettingStartedVM extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // on press buttton
  Future<void> onGettingStarted() async {
    _updateIsLoading(true);
    final _result = await AuthProvider().signInAnynomously();

    if (_result == null) _updateIsLoading(false);
  }

  // update value of isLoding
  void _updateIsLoading(final bool newVal) {
    _isLoading = newVal;
    notifyListeners();
  }
}
