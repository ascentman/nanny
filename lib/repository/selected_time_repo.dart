abstract class ISelectedTimeRepo {
  String get selectedDate;
  String get selectedTimeRange;
  void setDate(String date);
  void setTimeRange(String timeRange);
}

class SelectedTimeRepo implements ISelectedTimeRepo {
  String _selectedDate = '';
  String _selectedTimeRange = '';

  SelectedTimeRepo();

  @override
  String get selectedDate => _selectedDate;

  @override
  String get selectedTimeRange => _selectedTimeRange;

  @override
  void setDate(String date) {
    _selectedDate = date;
  }

  @override
  void setTimeRange(String timeRange) {
    _selectedTimeRange = timeRange;
  }
}
