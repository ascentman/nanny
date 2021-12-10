import 'package:flutter/foundation.dart';
import 'package:nanny/models/models.dart';
import 'package:nanny/repository/nanny_repo.dart';
import 'package:nanny/repository/selected_time_repo.dart';

abstract class INannyViewModel with ChangeNotifier {
  NannyState get state;

  Nanny get nanny;

  String get bookedDateTimeRange;

  bool get isLoading;

  String? get errorMessage;

  void setNanny(Nanny nanny);

  void resetNannyState();

  void sendBookingRequest(String name, String phone, VoidCallback onFinish);
}

enum NannyState { initial, loading, success, error }

class NannyViewModel with ChangeNotifier implements INannyViewModel {
  final INannyRepo _repo;
  final ISelectedTimeRepo _timeRepo;
  late Nanny _nanny;
  NannyState _state = NannyState.initial;
  String? _errorMessage;

  NannyViewModel(
      {required INannyRepo repo, required ISelectedTimeRepo timeRepo})
      : _repo = repo,
        _timeRepo = timeRepo;

  @override
  String? get errorMessage => _errorMessage;

  @override
  bool get isLoading => _state == NannyState.loading;

  @override
  NannyState get state => _state;

  @override
  Nanny get nanny => _nanny;

  @override
  String get bookedDateTimeRange =>
      '${_timeRepo.selectedDate},\n${_timeRepo.selectedTimeRange}';

  @override
  void sendBookingRequest(
      String name, String phone, VoidCallback onFinish) async {
    _setState(NannyState.loading);
    onFinish();
    int result = await _repo.sendEmail(
      nannyEmail: nanny.email,
      date: _timeRepo.selectedDate,
      time: _timeRepo.selectedTimeRange,
      name: name,
      phone: phone,
    );
    result == 200 ? _setState(NannyState.success) : _setState(NannyState.error);
  }

  @override
  void setNanny(Nanny nanny) {
    _nanny = nanny;
  }

  @override
  void resetNannyState() {
    _setState(NannyState.initial);
  }

  void _setState(NannyState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
