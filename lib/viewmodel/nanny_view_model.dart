import 'package:flutter/foundation.dart';
import 'package:nanny/repository/nanny_repo.dart';

abstract class INannyViewModel with ChangeNotifier {
  NannyState get state;

  bool get isLoading;

  String? get errorMessage;
}

enum NannyState { initial, loading, success, error }

class NannyViewModel with ChangeNotifier implements INannyViewModel {
  final INannyRepo _repo;
  NannyState _state = NannyState.initial;
  String? _errorMessage;

  NannyViewModel({required INannyRepo repo}) : _repo = repo;

  @override
  String? get errorMessage => _errorMessage;

  @override
  bool get isLoading => _state == NannyState.loading;

  @override
  NannyState get state => _state;

  void _setState(NannyState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
