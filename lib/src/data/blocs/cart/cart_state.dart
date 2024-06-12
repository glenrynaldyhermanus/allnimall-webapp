import 'package:allnimall_web/src/data/models/order_service.dart';

abstract class CartState {
  const CartState();
}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  const CartLoadedState(this.carts);

  final List<OrderService> carts;
}

class CartAddedState extends CartState {
  const CartAddedState(this.carts);

  final List<OrderService> carts;
}

class CartUnauthenticatedState extends CartState {}

class CartErrorState extends CartState {
  const CartErrorState(this.message);

  final String message;
}
