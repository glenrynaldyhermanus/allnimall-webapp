// ignore_for_file: functional_ref
import 'package:allnimall_web/src/core/injections/application_module.dart';
import 'package:allnimall_web/src/data/repositories/order_repository.dart';
import 'package:allnimall_web/src/data/repositories/service_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void initRepositoryModule(GetIt locator) {
  ///repositories

  locator.registerLazySingleton<OrderRepository>(
    () => OrderRepository(firestore: locator(), preferences: locator()),
  );

  locator.registerLazySingleton<ServiceRepository>(
    () => ServiceRepository(
      firestore: locator(),
    ),
  );
}


