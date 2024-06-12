import 'package:allnimall_web/src/core/injections/bloc_module.dart';
import 'package:allnimall_web/src/core/injections/repository_module.dart';
import 'package:allnimall_web/src/core/injections/usecase_module.dart';
import 'package:allnimall_web/src/core/preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> init() async {
  initRepositoryModule(locator);
  initUsecaseModule(locator);
  initBlocModule(locator);

  locator.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  locator.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  locator.registerLazySingleton<AMPreferences>(
    () => AMPreferences(
      locator(),
    ),
  );
}
