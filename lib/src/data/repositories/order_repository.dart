import 'dart:convert';

import 'package:allnimall_web/src/core/loggers/logger.dart';
import 'package:allnimall_web/src/core/preferences/shared_preferences.dart';
import 'package:allnimall_web/src/core/utils/errors/failures.dart';
import 'package:allnimall_web/src/core/utils/typedefs.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/models/service_add_on.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class OrderRepository {
  const OrderRepository({required this.firestore, required this.preferences});

  final FirebaseFirestore firestore;
  final AMPreferences preferences;

  ResultFuture<List<OrderService>> addServiceToCart({
    required String serviceUid,
    required String categoryName,
    required double fee,
    required String name,
    required int quantity,
    required List<ServiceAddOn> addOns,
  }) async {
    try {
      List<OrderService> cartList = [];
      if (preferences.storage.containsKey(PrefKey.cart)) {
        var jsonCarts = jsonDecode(preferences.readData(PrefKey.cart)!);

        for (var json in jsonCarts) {
          cartList.add(OrderService.fromJson(json));
        }
      }

      cartList.add(OrderService(
        serviceUid: serviceUid,
        categoryName: categoryName,
        fee: fee,
        name: name,
        quantity: quantity,
        addOns: addOns,
      ));
      preferences.writeData(
          PrefKey.cart,
          jsonEncode(
              cartList.map((orderService) => orderService.toJson()).toList()));

      return Right(cartList);
    } catch (e) {
      logger.e("addServiceToCart => $e");
      return Left(CacheFailure(
          message: "Oops layanan kami sedang bermasalah, mohon coba lagi",
          statusCode: 500));
    }
  }

  ResultFuture<List<OrderService>> getCart() async {
    try {
      List<OrderService> cartList = [];

      if (preferences.storage.containsKey(PrefKey.cart)) {
        var jsonCarts = jsonDecode(preferences.readData(PrefKey.cart)!);

        for (var json in jsonCarts) {
          cartList.add(OrderService.fromJson(json));
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
