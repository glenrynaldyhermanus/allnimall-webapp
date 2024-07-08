import 'package:allnimall_web/src/core/utils/base_state.dart';
import 'package:allnimall_web/src/data/models/order.dart';

class OrderServiceState extends BaseState<List<OrderModel>> {
  OrderServiceState({
    bool isLoading = false,
    bool isError = false,
    List<OrderModel>? data,
    String? message,
  }) : super(
            isLoading: isLoading,
            isError: isError,
            data: data,
            message: message);

  factory OrderServiceState.initial() {
    return OrderServiceState();
  }

  factory OrderServiceState.loading() {
    return OrderServiceState(isLoading: true);
  }

  factory OrderServiceState.success(List<OrderModel> data) {
    return OrderServiceState(data: data);
  }

  factory OrderServiceState.error(String message) {
    return OrderServiceState(isError: true, message: message);
  }
}
