import 'package:get_it/get_it.dart';
import 'package:nanny/repository/nannies_repo.dart';
import 'package:nanny/repository/nanny_repo.dart';
import 'package:nanny/repository/register_repo.dart';
import 'package:nanny/repository/selected_time_repo.dart';
import 'package:nanny/service/database_service.dart';
import 'package:nanny/service/email_service.dart';
import 'package:nanny/service/firebase_analytics_screen.dart';
import 'package:nanny/service/firebase_init.sevice.dart';
import 'package:nanny/service/remote_config_service.dart';

final GetIt sl = GetIt.I;

void setupLocator() {
  // Services
  sl.registerSingletonAsync<IFirebaseInitializationService>(
      () => FirebaseInitializationService().init());
  sl.registerLazySingleton<IDatabaseService>(() => DatabaseService());
  sl.registerLazySingleton<IEmailService>(() => EmailService());
  sl.registerLazySingleton<IAnalyticsService>(() => AnalyticsService());
  sl.registerLazySingleton<IRemoteConfigService>(() => RemoteConfigService());

  // Repositories
  sl.registerLazySingleton<ISelectedTimeRepo>(() => SelectedTimeRepo());
  sl.registerLazySingleton<INanniesRepo>(() => NanniesRepo(db: sl.get()));
  sl.registerLazySingleton<INannyRepo>(() => NannyRepo(emailService: sl.get()));
  sl.registerLazySingleton<IRegisterRepo>(() => RegisterRepo(db: sl.get()));
}
