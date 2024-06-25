import 'package:allnimall_web/src/data/models/order.dart';

abstract class OrderState {
  const OrderState();
}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderCreatedState extends OrderState {
  const OrderCreatedState(this.order);

  final GroomingOrder order;
}

class OrderUnauthenticatedState extends OrderState {}

class OrderErrorState extends OrderState {
  const OrderErrorState(this.message);

  final String message;
}
