import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:nanny/models/models.dart';
import 'package:nanny/repository/nannies_repo.dart';

abstract class INanniesViewModel with ChangeNotifier {
  List<Nanny> get nannies;
}

class NanniesViewModel with ChangeNotifier implements INanniesViewModel {
  final INanniesRepo _repo;
  List<Nanny> _nannies = [];
  static const nanniesPath = 'nannies';
  late StreamSubscription<List<Nanny>> _nanniesSub;
  @override
  List<Nanny> get nannies => _nannies;

  NanniesViewModel({required INanniesRepo repo}) : _repo = repo {
    _listenToNannies();
  }

  void _listenToNannies() {
    _nanniesSub = _repo.getNannies().listen((event) {
      _nannies = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _nanniesSub.cancel();
    super.dispose();
  }
}
