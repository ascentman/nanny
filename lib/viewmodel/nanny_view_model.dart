import 'package:flutter/foundation.dart';
import 'package:nanny/models/models.dart';
import 'package:nanny/repository/nanny_repo.dart';

abstract class INannyViewModel with ChangeNotifier {
  NannyState get state;

  Nanny get nanny;

  bool get isLoading;

  String? get errorMessage;

  void setNanny(Nanny nanny);

  void sendBookingRequest(String name, String phone, VoidCallback onFinish);
}

enum NannyState { initial, loading, success, error }

class NannyViewModel with ChangeNotifier implements INannyViewModel {
  final INannyRepo _repo;
  late Nanny _nanny;
  NannyState _state = NannyState.initial;
  String? _errorMessage;

  NannyViewModel({required INannyRepo repo}) : _repo = repo;

  @override
  String? get errorMessage => _errorMessage;

  @override
  bool get isLoading => _state == NannyState.loading;

  @override
  NannyState get state => _state;

  @override
  Nanny get nanny => _nanny;

  @override
  void sendBookingRequest(
      String name, String phone, VoidCallback onFinish) async {
    _setState(NannyState.loading);
    onFinish();
    int result = await _repo.sendEmail(name, phone);
    result == 200 ? _setState(NannyState.success) : _setState(NannyState.error);
  }

  @override
  void setNanny(Nanny nanny) {
    _nanny = nanny;
  }

  void _setState(NannyState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
