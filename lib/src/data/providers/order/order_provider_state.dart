import 'package:allnimall_web/src/core/utils/base_state.dart';
import 'package:allnimall_web/src/data/models/order.dart';

class OrderProviderState extends BaseState<List<OrderModel>> {
  OrderProviderState({
    bool isLoading = false,
    bool isError = false,
    List<OrderModel>? data,
    String? message,
  }) : super(
            isLoading: isLoading,
            isError: isError,
            data: data,
            message: message);

  factory OrderProviderState.initial() {
    return OrderProviderState();
  }

  factory OrderProviderState.loading() {
    return OrderProviderState(isLoading: true);
  }

  factory OrderProviderState.success(List<OrderModel> data) {
    return OrderProviderState(data: data);
  }

  factory OrderProviderState.error(String message) {
    return OrderProviderState(isError: true, message: message);
  }
}
