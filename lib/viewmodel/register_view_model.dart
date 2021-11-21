import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:nanny/repository/register_repo.dart';

abstract class IRegisterViewModel with ChangeNotifier {
  LoginState get state;

  bool get isLoading;

  bool get isSignInFlow;

  String? get errorMessage;

  void signIn({required String email, required String password});

  void signUp({required String email, required String password});

  void registerSelected();
  void signInSelected();
}

enum LoginState { initial, loading, success, error }

class RegisterViewModel with ChangeNotifier implements IRegisterViewModel {
  final IRegisterRepo _repo;
  LoginState _state = LoginState.initial;
  String? _errorMessage;
  bool _isSignInFlow;

  late StreamSubscription<User?> _authStateSub;

  RegisterViewModel({required IRegisterRepo repo})
      : _repo = repo,
        _isSignInFlow = true;

  @override
  bool get isSignInFlow => _isSignInFlow;

  @override
  String? get errorMessage => _errorMessage;

  @override
  bool get isLoading => _state == LoginState.loading;

  @override
  LoginState get state => _state;

  void _setState(LoginState viewState) {
    _state = viewState;
    notifyListeners();
  }

  @override
  void registerSelected() {
    _isSignInFlow = false;
    notifyListeners();
  }

  @override
  void signInSelected() {
    _isSignInFlow = true;
    notifyListeners();
  }

  @override
  void dispose() {
    _authStateSub.cancel();
    super.dispose();
  }

  @override
  void signIn({required String email, required String password}) async {
    _setState(LoginState.loading);
    String result = await _repo.signIn(email: email, password: password);
    if (result == 'Success') {
      _setState(LoginState.success);
    } else {
      _errorMessage = result;
      _setState(LoginState.error);
    }
  }

  @override
  void signUp({required String email, required String password}) async {
    _setState(LoginState.loading);
    String result = await _repo.signUp(email: email, password: password);
    if (result == 'Success') {
      _setState(LoginState.success);
    } else {
      _errorMessage = result;
      _setState(LoginState.error);
    }
  }
}
