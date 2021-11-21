import 'package:firebase_auth/firebase_auth.dart';
import 'package:nanny/models/models.dart';
import 'package:nanny/service/database_service.dart';

abstract class INanniesRepo {
  Stream<List<Nanny>> getNannies();
  Stream<User?> get authStateChanges;
  Future<void> addNanny(Nanny nanny);
  Future<void> updateNanny(Nanny nanny);
  Future<void> deleteNanny(Nanny nanny);
}

class NanniesRepo implements INanniesRepo {
  final IDatabaseService _db;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  NanniesRepo({required IDatabaseService db}) : _db = db;

  @override
  Stream<List<Nanny>> getNannies() {
    return _db.streamDataCollection(path: 'nannies').map(
        (snap) => snap.docs.map((doc) => Nanny.fromSnapshot(doc)).toList());
  }

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

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
}
