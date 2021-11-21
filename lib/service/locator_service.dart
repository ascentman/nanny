import 'package:get_it/get_it.dart';
import 'package:nanny/repository/nannies_repo.dart';
import 'package:nanny/repository/nanny_repo.dart';
import 'package:nanny/repository/register_repo.dart';
import 'package:nanny/service/database_service.dart';

final GetIt sl = GetIt.I;

void setupLocator() {
  // // Services
  sl.registerLazySingleton<IDatabaseService>(() => DatabaseService());

  // Repositories
  sl.registerLazySingleton<INanniesRepo>(() => NanniesRepo(db: sl.get()));
  sl.registerLazySingleton<INannyRepo>(() => NannyRepo(db: sl.get()));
  sl.registerLazySingleton<IRegisterRepo>(() => RegisterRepo(db: sl.get()));
}
