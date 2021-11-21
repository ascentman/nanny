import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:nanny/repository/nanny_repo.dart';

abstract class INannyViewModel with ChangeNotifier {
  LoginState get state;

  bool get isLoading;

  String? get errorMessage;
}

enum LoginState { initial, loading, success, error }

class NannyViewModel with ChangeNotifier implements INannyViewModel {
  final INannyRepo _repo;
  LoginState _state = LoginState.initial;
  String? _errorMessage;

  late StreamSubscription<User?> _authStateSub;

  NannyViewModel({required INannyRepo repo}) : _repo = repo;

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
}
