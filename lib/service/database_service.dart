import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

abstract class IDatabaseService {
  Future<DocumentSnapshot> getDocumentById({
    required String path,
    required String id,
  });

  Future<QuerySnapshot<Map<String, dynamic>>> getDocuments({
    required String path,
  });

  Future<QuerySnapshot> orderedDataCollection({
    required String path,
    required String orderBy,
    required bool isDescending,
    String? selectedWeekday,
    int? selectedCityOption,
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
  Future<QuerySnapshot> orderedDataCollection({
    required String path,
    required String orderBy,
    required bool isDescending,
    String? selectedWeekday,
    int? selectedCityOption = 1,
  }) async {
    if (selectedWeekday != null) {
      final citiesCollection = await getDocuments(path: 'cities');
      final cities = citiesCollection.docs
          .map((snap) => City.fromMap(snap.data()))
          .toList();
      final selectedCity = cities.elementAt((selectedCityOption ?? 1) - 1);
      return _db
          .collection(path)
          .where('town', isEqualTo: selectedCity.name)
          .where('workingDaysEng', arrayContains: selectedWeekday)
          .orderBy(orderBy, descending: isDescending)
          .get();
    } else {
      return _db
          .collection(path)
          .orderBy(orderBy, descending: isDescending)
          .get();
    }
  }

  @override
  Future<DocumentSnapshot> getDocumentById(
      {required String path, required String id}) {
    return _db.collection(path).doc(id).get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getDocuments({
    required String path,
  }) {
    return _db.collection(path).get();
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
}
