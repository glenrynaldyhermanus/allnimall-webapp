import 'package:allnimall_web/src/data/blocs/cart/cart_event.dart';
import 'package:allnimall_web/src/data/blocs/cart/cart_state.dart';
import 'package:allnimall_web/src/data/usecases/order/add_service_to_cart.dart';
import 'package:allnimall_web/src/data/usecases/order/get_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  ///Usecases
  final AddServiceToCart _addServiceToCart;
  final GetCart _getCart;

  ///Bloc
  CartBloc({
    required AddServiceToCart addServiceToCart,
    required GetCart getCart,
  })  : _addServiceToCart = addServiceToCart,
        _getCart = getCart,
        super(CartInitialState()) {
    on<CartEvent>((event, emit) {
      emit(CartLoadingState());
    });

    on<AddServiceToCartEvent>(_addServiceToCartEventHandler);
    on<CheckCartEvent>(_checkCartEventHandler);
  }

  ///Handler
  Future<void> _addServiceToCartEventHandler(
    AddServiceToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());

    try {
      final result = await _addServiceToCart(AddServiceToCartParams(
        serviceUid: event.serviceUid,
        categoryName: event.categoryName,
        fee: event.fee,
        name: event.name,
        quantity: event.quantity,
        addOns: event.addOns,
      ));

      result.fold(
        (failure) => emit(CartErrorState(failure.errorMessage)),
        (cartList) => emit(CartAddedState(cartList)),
      );
    } catch (e) {
      // Handle exceptions if any
      emit(CartErrorState('Error occured: $e'));
    }
  }

  Future<void> _checkCartEventHandler(
    CheckCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());

    try {
      final result = await _getCart();

      result.fold(
        (failure) => emit(CartErrorState(failure.errorMessage)),
        (cartList) => emit(CartAddedState(cartList)),
      );
    } catch (e) {
      // Handle exceptions if any
      emit(CartErrorState('Error occured: $e'));
    }
  }
}
