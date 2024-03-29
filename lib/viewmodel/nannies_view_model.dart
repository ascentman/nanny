import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nanny/models/models.dart';
import 'package:nanny/repository/nannies_repo.dart';
import 'package:nanny/repository/selected_time_repo.dart';

abstract class INanniesViewModel with ChangeNotifier {
  List<Nanny> get nannies;

  bool get isLoading;

  int get activeFilterOption;

  int get selectedCityOption;

  String get selectedCity;

  DateTime get chosenDateTime;

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

  void setCity(int city, VoidCallback onFinish);

  Nanny findById(String? id);
}

class NanniesViewModel with ChangeNotifier implements INanniesViewModel {
  final INanniesRepo _repo;
  final ISelectedTimeRepo _timeRepo;
  List<Nanny> _nannies = [];
  bool _isLoading = false;
  static const nanniesPath = 'nannies';
  late String _selectedDateString;
  TimeOfDay _selectedStartHour = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _selectedEndHour = const TimeOfDay(hour: 18, minute: 0);
  int _activeFilterOption = 1;
  int _selectedCityOption = 1;
  String _selectedCity = 'Тальне';
  DateTime _chosenDateTime = DateTime.now();

  NanniesViewModel(
      {required ISelectedTimeRepo timeRepo, required INanniesRepo repo})
      : _repo = repo,
        _timeRepo = timeRepo {
    _fetchNannies();
    _selectedDateString = _dayAndMonthFormatted(null);
    _updateSelectedTime();
    _updateSelectedDate();
  }

  @override
  int get activeFilterOption => _activeFilterOption;

  @override
  int get selectedCityOption => _selectedCityOption;

  @override
  String get selectedCity => _selectedCity;

  @override
  List<Nanny> get nannies => _nannies;

  @override
  bool get isLoading => _isLoading;

  @override
  DateTime get chosenDateTime => _chosenDateTime;

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
      return '${_nannies.length} нянь у';
    }
    switch ((_nannies.length % 10)) {
      case 1:
        return '${_nannies.length} няня у';
      case 2:
      case 3:
      case 4:
        return '${_nannies.length} няні у';
      default:
        return '${_nannies.length} нянь у';
    }
  }

  @override
  void selectPickerDate(DateTime? dateTime) async {
    if (dateTime != null) {
      _chosenDateTime = dateTime;
    }
    _selectedDateString = _dayAndMonthFormatted(dateTime);
    _updateSelectedDate();
    if (dateTime != null) {
      _nannies = await _repo.getOrderedNanniesBy(
        _activeFilterOption,
        DateFormat('EEEE').format(dateTime),
        _selectedCityOption,
      );
    }
    notifyListeners();
  }

  @override
  void selectStartHour(TimeOfDay? tod) {
    if (tod != null) {
      _selectedStartHour = tod;
    }
    _updateSelectedTime();
    notifyListeners();
  }

  @override
  void selectEndHour(TimeOfDay? tod) {
    if (tod != null) {
      _selectedEndHour = tod;
    }
    _updateSelectedTime();
    notifyListeners();
  }

  @override
  void setFilter(int option, VoidCallback onFinish) async {
    _activeFilterOption = option;
    notifyListeners();
    _nannies = await _repo.getOrderedNanniesBy(
      option,
      DateFormat('EEEE').format(_chosenDateTime),
      _selectedCityOption,
    );
    notifyListeners();
    onFinish();
  }

  @override
  void setCity(int cityOption, VoidCallback onFinish) async {
    _selectedCityOption = cityOption;
    _selectedCity = await _repo.getSelectedCity(cityOption);
    notifyListeners();
    _nannies = await _repo.getOrderedNanniesBy(
      _activeFilterOption,
      DateFormat('EEEE').format(_chosenDateTime),
      _selectedCityOption,
    );
    notifyListeners();
    onFinish();
  }

  @override
  Nanny findById(String? id) =>
      _nannies.firstWhere((nanny) => nanny.referenceId == id);

  void _fetchNannies() async {
    _setLoadingState(true);
    _nannies = await _repo.getOrderedNanniesBy(
      _activeFilterOption,
      DateFormat('EEEE').format(_chosenDateTime),
      _selectedCityOption,
    );
    _setLoadingState(false);
  }

  void _setLoadingState(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
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

  void _updateSelectedTime() => _timeRepo.setTimeRange(timeRangeString);

  void _updateSelectedDate() => _timeRepo.setDate(_selectedDateString);
}
