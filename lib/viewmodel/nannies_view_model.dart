import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nanny/models/models.dart';
import 'package:nanny/repository/nannies_repo.dart';

abstract class INanniesViewModel with ChangeNotifier {
  List<Nanny> get nannies;

  int get activeFilterOption;

  String get selectedDateString;

  TimeOfDay get selectedStartHour;

  TimeOfDay get selectedEndHour;

  String get timeRangeString;

  void addNanny(Nanny nanny);

  String getNanniesCount();

  void selectPickerDate(DateTime? dateTime);

  void selectStartHour(TimeOfDay? tod);

  void selectEndHour(TimeOfDay? tod);

  void setFilter(int option, VoidCallback onFinish);

  Nanny findById(String? id);
}

class NanniesViewModel with ChangeNotifier implements INanniesViewModel {
  final INanniesRepo _repo;
  List<Nanny> _nannies = [];
  static const nanniesPath = 'nannies';
  late StreamSubscription<List<Nanny>> _nanniesSub;
  late String _selectedDateString;
  late TimeOfDay _selectedStartHour;
  late TimeOfDay _selectedEndHour;
  int _activeFilterOption = 1;

  NanniesViewModel({required INanniesRepo repo}) : _repo = repo {
    _listenToNannies();
    _selectedDateString = _dayAndMonthFormatted(null);
    selectStartHour(null);
    selectEndHour(null);
  }

  @override
  int get activeFilterOption => _activeFilterOption;

  @override
  List<Nanny> get nannies => _nannies;

  @override
  String get selectedDateString => _selectedDateString;

  @override
  TimeOfDay get selectedStartHour => _selectedStartHour;

  @override
  TimeOfDay get selectedEndHour => _selectedEndHour;

  @override
  String get timeRangeString =>
      '${_timeFormatted(_selectedStartHour)} - ${_timeFormatted(_selectedEndHour)}';

  @override
  void addNanny(Nanny nanny) {
    _repo.addNanny(nanny);
  }

  @override
  String getNanniesCount() {
    if (_nannies.length > 10 && _nannies.length < 20) {
      return '${_nannies.length} нянь';
    }
    switch ((_nannies.length % 10)) {
      case 1:
        return '${_nannies.length} няня';
      case 2:
      case 3:
      case 4:
        return '${_nannies.length} няні';
      default:
        return '${_nannies.length} нянь';
    }
  }

  @override
  void selectPickerDate(DateTime? dateTime) {
    _selectedDateString = _dayAndMonthFormatted(dateTime);
    notifyListeners();
  }

  @override
  void selectStartHour(TimeOfDay? tod) {
    _selectedStartHour = tod ?? const TimeOfDay(hour: 9, minute: 0);
    notifyListeners();
  }

  @override
  void selectEndHour(TimeOfDay? tod) {
    _selectedEndHour = tod ?? const TimeOfDay(hour: 18, minute: 0);
    notifyListeners();
  }

  @override
  void setFilter(int option, VoidCallback onFinish) async {
    _activeFilterOption = option;
    notifyListeners();
    _nannies = await _repo.getOrderedNanniesBy(option);
    notifyListeners();
    onFinish();
  }

  @override
  Nanny findById(String? id) {
    return _nannies.first; //Where((nanny) => nanny.referenceId == id);
  }

  void _listenToNannies() {
    _nanniesSub = _repo.getNannies().listen((event) {
      _nannies = event;
      notifyListeners();
    });
  }

  String _dayAndMonthFormatted(DateTime? dateTime) {
    var format = DateFormat.MMMMd('uk');
    return format.format(dateTime ?? DateTime.now());
  }

  String _timeFormatted(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm('uk');
    return format.format(dt);
  }

  @override
  void dispose() {
    _nanniesSub.cancel();
    super.dispose();
  }
}
