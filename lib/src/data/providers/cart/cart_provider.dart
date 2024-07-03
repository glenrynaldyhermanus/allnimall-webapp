import 'package:allnimall_web/src/data/models/service_add_on.dart';
import 'package:allnimall_web/src/data/providers/cart/cart_provider_state.dart';
import 'package:allnimall_web/src/data/usecases/order/add_service_to_cart.dart';
import 'package:allnimall_web/src/data/usecases/order/clear_cart.dart';
import 'package:allnimall_web/src/data/usecases/order/get_cart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@riverpod
class Cart extends _$Cart {
  Cart();

  ///Usecases
  late final AddServiceToCart _addServiceToCart;
  late final GetCart _getCart;
  late final ClearCart _clearCart;

  void init(
    AddServiceToCart addServiceToCart,
    GetCart getCart,
    ClearCart clearCart,
  ) {
    _addServiceToCart = addServiceToCart;
    _getCart = getCart;
    _clearCart = clearCart;
  }

  @override
  CartProviderState build() {
    return CartProviderState.initial();
  }

  Future<void> addServiceToCart(
      String serviceUid,
      String categoryName,
      double fee,
      String name,
      int quantity,
      List<ServiceAddOnModel> addOns) async {
    state = CartProviderState.loading();

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
        state = CartProviderState.error(failure.message);
      },
      (data) {
        state = CartProviderState.success(data);
      },
    );
  }

  Future<void> clearCart() async {
    state = CartProviderState.loading();

    final result = await _clearCart();

    result.fold(
      (failure) {
        state = CartProviderState.error(failure.message);
      },
      (data) {
        state = CartProviderState.success(data);
      },
    );
  }

  Future<void> getCart() async {
    state = CartProviderState.loading();

    final result = await _getCart();

    result.fold(
      (failure) {
        state = CartProviderState.error(failure.message);
      },
      (data) {
        state = CartProviderState.success(data);
      },
    );
  }
}
