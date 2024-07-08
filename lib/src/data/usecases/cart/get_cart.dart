import 'dart:convert';

import 'package:allnimall_web/src/core/injections/application_module.dart';
import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:allnimall_web/src/core/preferences/shared_preferences.dart';
import 'package:allnimall_web/src/core/utils/errors/failures.dart';
import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_cart.g.dart';

class GetCart extends UsecaseWithoutParams<List<OrderServiceModel>> {
  const GetCart(this.preferences);

  final AMPreferences preferences;

  @override
  ResultFuture<List<OrderServiceModel>> call() async {
    try {
      List<OrderServiceModel> cartList = [];

      if (preferences.storage.containsKey(PrefKey.cart)) {
        var jsonCarts = jsonDecode(preferences.readData(PrefKey.cart)!);

        for (var json in jsonCarts) {
          cartList.add(OrderServiceModel.fromJson(json));
        }
      }

      return Right(cartList);
    } catch (e) {
      logger.e("getCart => $e");
      return Left(CacheFailure(
          message: "Oops layanan kami sedang bermasalah, mohon coba lagi",
          statusCode: 500));
    }
  }
}

@riverpod
GetCart getCart(GetCartRef ref) {
  final pref = ref.watch(amPreferencesProvider);
  return GetCart(pref);
}
