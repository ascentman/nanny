import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:nanny/firebase_options.dart';

import 'async_init.dart';

/// Initialisation service used to postpone other Firebase-related
/// services until firebase will be initialised.
abstract class IFirebaseInitializationService {}

class FirebaseInitializationService
    implements
        IFirebaseInitializationService,
        IAsyncServiceInitializer<IFirebaseInitializationService> {
  @override
  Future<IFirebaseInitializationService> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    return this;
  }
}
