// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:allnimall_web/src/data/models/service_add_on.dart';
import 'package:allnimall_web/src/data/providers/cart/cart_service_state.dart';
import 'package:allnimall_web/src/data/usecases/order/add_service_to_cart.dart';
import 'package:allnimall_web/src/data/usecases/order/clear_cart.dart';
import 'package:allnimall_web/src/data/usecases/order/get_cart.dart';
import 'package:allnimall_web/src/data/usecases/order/remove_service_from_cart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_service_provider.g.dart';

@riverpod
class CartService extends _$CartService { 
  ///Usecases
  late AddServiceToCart _addServiceToCart;
  late GetCart _getCart;
  late ClearCart _clearCart;
  late RemoveServiceFromCart _removeServiceFromCart;

  @override
  CartServiceState build() {
    _addServiceToCart = ref.watch(addServiceToCartProvider);
    _getCart = ref.watch(getCartProvider);
    _clearCart = ref.watch(clearCartProvider);
    _removeServiceFromCart = ref.watch(removeServiceFromCartProvider);

    return CartServiceState.initial();
  }

  Future<void> addServiceToCart(
      String serviceUid,
      String categoryName,
      double fee,
      String name,
      int quantity,
      List<ServiceAddOnModel> addOns) async {
    state = CartServiceState.loading();

    final result = await _addServiceToCart(AddServiceToCartParams(
      serviceUid: serviceUid,
      categoryName: categoryName,
      fee: fee,
      name: name,
      quantity: quantity,
      addOns: addOns,
    ));

    result.fold(
      (failure) {
        state = CartServiceState.error(failure.message);
      },
      (data) {
        state = CartServiceState.success(data);
      },
    );
  }

  Future<void> removeServiceFromCart(String serviceUid) async {
    state = CartServiceState.loading();

    final result = await _removeServiceFromCart(RemoveServiceFromCartParams(
      serviceUid: serviceUid,
    ));

    result.fold(
      (failure) {
        state = CartServiceState.error(failure.message);
      },
      (data) {
        state = CartServiceState.success(data);
      },
    );
  }

  Future<void> clearCart() async {
    state = CartServiceState.loading();

    final result = await _clearCart();

    result.fold(
      (failure) {
        state = CartServiceState.error(failure.message);
      },
      (data) {
        state = CartServiceState.success(data);
      },
    );
  }

  Future<void> getCart() async {
    state = CartServiceState.loading();

    final result = await _getCart();

    result.fold(
      (failure) {
        state = CartServiceState.error(failure.message);
      },
      (data) {
        state = CartServiceState.success(data);
      },
    );
  }
}
