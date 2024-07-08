import 'dart:convert';

import 'package:allnimall_web/src/core/injections/application_module.dart';
import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:allnimall_web/src/core/preferences/shared_preferences.dart';
import 'package:allnimall_web/src/core/utils/errors/failures.dart';
import 'package:allnimall_web/src/core/utils/functions/is_service_exists_in_cart.dart';
import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/core/utils/usecase.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/models/service_add_on.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_service_to_cart.g.dart';

class AddServiceToCart
    extends UsecaseWithParams<List<OrderServiceModel>, AddServiceToCartParams> {
  const AddServiceToCart(this.firestore, this.preferences);

  final FirebaseFirestore firestore;
  final AMPreferences preferences;

  @override
  ResultFuture<List<OrderServiceModel>> call(
      AddServiceToCartParams params) async {
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
        cartList[index] = OrderServiceModel(
          serviceUid: params.serviceUid,
          categoryName: params.categoryName,
          fee: params.fee,
          name: params.name,
          quantity: params.quantity,
          addOns: params.addOns,
        );
      } else {
        /// Adds additional cart
        cartList.add(OrderServiceModel(
          serviceUid: params.serviceUid,
          categoryName: params.categoryName,
          fee: params.fee,
          name: params.name,
          quantity: params.quantity,
          addOns: params.addOns,
        ));
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

class AddServiceToCartParams {
  const AddServiceToCartParams({
    required this.serviceUid,
    required this.categoryName,
    required this.fee,
    required this.name,
    required this.quantity,
    required this.addOns,
  });

  const AddServiceToCartParams.empty()
      : this(
            serviceUid: '',
            categoryName: '',
            fee: 0,
            name: '',
            quantity: 0,
            addOns: const []);

  final String serviceUid;
  final String categoryName;
  final double fee;
  final String name;
  final int quantity;
  final List<ServiceAddOnModel> addOns;
}

@riverpod
AddServiceToCart addServiceToCart(AddServiceToCartRef ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final preference = ref.watch(amPreferencesProvider);
  return AddServiceToCart(firestore, preference);
}
