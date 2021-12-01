import 'package:nanny/models/models.dart';
import 'package:nanny/service/database_service.dart';

abstract class INanniesRepo {
  Stream<List<Nanny>> getNannies();
  Future<void> addNanny(Nanny nanny);
  Future<void> updateNanny(Nanny nanny);
  Future<void> deleteNanny(Nanny nanny);
  Future<List<Nanny>> getOrderedNanniesBy(int option);
}

class NanniesRepo implements INanniesRepo {
  final IDatabaseService _db;

  NanniesRepo({required IDatabaseService db}) : _db = db;

  @override
  Stream<List<Nanny>> getNannies() {
    return _db.streamDataCollection(path: 'nannies').map(
        (snap) => snap.docs.map((doc) => Nanny.fromSnapshot(doc)).toList());
  }

  @override
  Future<List<Nanny>> getOrderedNanniesBy(int option) async {
    switch (option) {
      case 3:
        return _filterBy('payment', isDescending: false);
      case 4:
        return _filterBy('payment', isDescending: true);
      default:
        return _filterBy('rating', isDescending: true);
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

  Future<List<Nanny>> _filterBy(
    String orderBy, {
    required bool isDescending,
  }) async {
    return (await _db.orderedDataCollection(
            path: 'nannies', orderBy: orderBy, isDescending: isDescending))
        .docs
        .map((snap) => Nanny.fromSnapshot(snap))
        .toList();
  }
}
