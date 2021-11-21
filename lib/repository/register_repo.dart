import 'package:firebase_auth/firebase_auth.dart';
import 'package:nanny/models/models.dart';
import 'package:nanny/service/database_service.dart';

abstract class IRegisterRepo {
  Stream<User?> get authStateChanges;

  Future<String> signIn({
    required String email,
    required String password,
  });
  Future<String> signUp({
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<void> addUserToDb(UserModel user);
}

class RegisterRepo implements IRegisterRepo {
  final IDatabaseService _db;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RegisterRepo({required IDatabaseService db}) : _db = db;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "Такого користувача не знайдено";
      } else if (e.code == 'wrong-password') {
        return "Невірний пароль";
      } else if (e.code == 'invalid-email') {
        return "Невірна e-mail адреса";
      } else {
        return "Щось пішло не так";
      }
    }
  }

  @override
  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'Акаунт вже створений з цією e-mail адресою';
      } else if (e.code == 'invalid-email') {
        return 'Невірна e-mail адреса';
      } else {
        return 'Щось пішло не так';
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> addUserToDb(UserModel user) async {
    await _db.addDocument(path: 'users', data: user.toMap());
  }
}
