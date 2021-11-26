import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IDatabaseService {
  Stream<QuerySnapshot> streamDataCollection({required String path});

  Future<DocumentSnapshot> getDocumentById({
    required String path,
    required String id,
  });

  Future<QuerySnapshot> orderedDataCollection({
    required String path,
    required String orderBy,
    required bool isDescending,
  });

  Future<void> removeDocument({
    required String path,
    required String id,
  });

  Future<DocumentReference> addDocument({
    required String path,
    required Map<String, dynamic> data,
  });

  Future<void> updateDocument({
    required String path,
    required String id,
    required Map<String, dynamic> data,
  });
}

class DatabaseService implements IDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot> streamDataCollection({required String path}) {
    return _db.collection(path).snapshots();
  }

  @override
  Future<QuerySnapshot> orderedDataCollection({
    required String path,
    required String orderBy,
    required bool isDescending,
  }) {
    return _db
        .collection(path)
        .orderBy(orderBy, descending: isDescending)
        .get();
  }

  @override
  Future<DocumentSnapshot> getDocumentById(
      {required String path, required String id}) {
    return _db.collection(path).doc(id).get();
  }

  @override
  Future<void> removeDocument({required String path, required String id}) {
    return _db.collection(path).doc(id).delete();
  }

  @override
  Future<DocumentReference> addDocument(
      {required String path, required Map<String, dynamic> data}) {
    return _db.collection(path).add(data);
  }

  @override
  Future<void> updateDocument(
      {required String path,
      required String id,
      required Map<String, dynamic> data}) {
    return _db.collection(path).doc(id).update(data);
  }

  @override
  Stream<QuerySnapshot<Object?>> streamOrderedDataCollection(
      {required String path,
      required String orderBy,
      required bool isDescending}) {
    // TODO: implement streamOrderedDataCollection
    throw UnimplementedError();
  }
}
