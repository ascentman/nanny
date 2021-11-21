import 'package:nanny/models/models.dart';
import 'package:nanny/service/database_service.dart';

abstract class INannyRepo {
  Future<void> addUserToDb(UserModel user);
}

class NannyRepo implements INannyRepo {
  final IDatabaseService _db;

  NannyRepo({required IDatabaseService db}) : _db = db;

  @override
  Future<void> addUserToDb(UserModel user) async {
    await _db.addDocument(path: 'users', data: user.toMap());
  }
}
