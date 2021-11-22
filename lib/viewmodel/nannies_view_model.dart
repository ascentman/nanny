import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:nanny/models/models.dart';
import 'package:nanny/repository/nannies_repo.dart';

abstract class INanniesViewModel with ChangeNotifier {
  List<Nanny> get nannies;
  void addNanny(Nanny nanny);
  void listenToNannies();
  void listenToAuthState();
  String getNanniesCount();
}

class NanniesViewModel with ChangeNotifier implements INanniesViewModel {
  final INanniesRepo _repo;
  List<Nanny> _nannies = [];
  static const nanniesPath = 'nannies';
  late StreamSubscription<List<Nanny>> _nanniesSub;
  late StreamSubscription<User?> _authStateSub;
  @override
  List<Nanny> get nannies => _nannies;

  NanniesViewModel({required INanniesRepo repo}) : _repo = repo;

  @override
  void listenToNannies() {
    _nanniesSub = _repo.getNannies().listen((event) {
      _nannies = event;
      notifyListeners();
    });
  }

  @override
  void listenToAuthState() {
    _authStateSub = _repo.authStateChanges.listen((user) {
      print(user?.email ?? 'no email!!!');
      notifyListeners();
    });
  }

  @override
  void addNanny(Nanny nanny) {
    _repo.addNanny(nanny);
  }

  @override
  String getNanniesCount() {
    switch (_nannies.length % 10) {
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
  void dispose() {
    _nanniesSub.cancel();
    _authStateSub.cancel();
    super.dispose();
  }
}
