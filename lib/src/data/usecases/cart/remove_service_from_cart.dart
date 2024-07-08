import 'dart:convert';

import 'package:allnimall_web/src/core/injections/application_module.dart';
import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:allnimall_web/src/core/preferences/shared_preferences.dart';
import 'package:allnimall_web/src/core/utils/errors/failures.dart';
import 'package:allnimall_web/src/core/utils/functions/is_service_exists_in_cart.dart';
import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remove_service_from_cart.g.dart';

class RemoveServiceFromCart extends UsecaseWithParams<List<OrderServiceModel>,
    RemoveServiceFromCartParams> {
  const RemoveServiceFromCart(this.preferences);

  final AMPreferences preferences;

  @override
  ResultFuture<List<OrderServiceModel>> call(
      RemoveServiceFromCartParams params) async {
    try {
      List<OrderServiceModel> cartList = [];

      /// Get carts from local storage
      if (preferences.storage.containsKey(PrefKey.cart)) {
        var jsonCarts = jsonDecode(preferences.readData(PrefKey.cart)!);

        for (var json in jsonCarts) {
          cartList.add(OrderServiceModel.fromJson(json));
        }
      }

      /// Check if add or update
      if (isServiceExistsInCart(cartList, params.serviceUid)) {
        /// Update cart by getting the index
        final index =
            cartList.indexWhere((item) => item.serviceUid == params.serviceUid);
        cartList.removeAt(index);
      }

      /// Push back to local storage
      preferences.writeData(
          PrefKey.cart,
          jsonEncode(
              cartList.map((orderService) => orderService.toJson()).toList()));

      /// Return the list
      return Right(cartList);
    } catch (e) {
      logger.e("addServiceToCart => $e");
      return Left(CacheFailure(
          message: "Oops layanan kami sedang bermasalah, mohon coba lagi",
          statusCode: 500));
    }
  }
}

class RemoveServiceFromCartParams {
  const RemoveServiceFromCartParams({required this.serviceUid});

  const RemoveServiceFromCartParams.empty() : this(serviceUid: '');

  final String serviceUid;
}

@riverpod
RemoveServiceFromCart removeServiceFromCart(RemoveServiceFromCartRef ref) {
  final pref = ref.watch(amPreferencesProvider);
  return RemoveServiceFromCart(pref);
}
