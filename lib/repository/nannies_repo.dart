import 'package:nanny/models/models.dart';
import 'package:nanny/service/database_service.dart';

abstract class INanniesRepo {
  Future<void> addNanny(Nanny nanny);
  Future<void> updateNanny(Nanny nanny);
  Future<void> deleteNanny(Nanny nanny);
  Future<List<Nanny>> getOrderedNanniesBy(int option, String? selectedWeekday);
}

class NanniesRepo implements INanniesRepo {
  final IDatabaseService _db;

  NanniesRepo({required IDatabaseService db}) : _db = db;

  @override
  Future<List<Nanny>> getOrderedNanniesBy(
    int option,
    String? selectedWeekday,
  ) async {
    switch (option) {
      case 2:
        return _filterBy(
          orderBy: 'reviewsCount',
          isDescending: true,
          selectedWeekday: selectedWeekday,
        );
      case 3:
        return _filterBy(
          orderBy: 'payment',
          isDescending: false,
          selectedWeekday: selectedWeekday,
        );
      default:
        return _filterBy(
          orderBy: 'rating',
          isDescending: true,
          selectedWeekday: selectedWeekday,
        );
    }
  }

  @override
  Future<void> addNanny(Nanny nanny) async {
    await _db.addDocument(path: 'nannies', data: nanny.toMap());
  }

  @override
  Future<void> updateNanny(Nanny nanny) async {
    await _db.updateDocument(
        path: 'nannies', id: nanny.referenceId ?? '', data: nanny.toMap());
  }

  @override
  Future<void> deleteNanny(Nanny nanny) async {
    await _db.removeDocument(path: 'nannies', id: nanny.referenceId ?? '');
  }

  Future<List<Nanny>> _filterBy({
    required String orderBy,
    required bool isDescending,
    String? selectedWeekday,
  }) async {
    return (await _db.orderedDataCollection(
      path: 'nannies',
      orderBy: orderBy,
      isDescending: isDescending,
      selectedWeekday: selectedWeekday,
    ))
        .docs
        .map((snap) => Nanny.fromSnapshot(snap))
        .toList();
  }
}
