import 'package:allnimall_web/src/core/utils/base_state.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';

class CartServiceState extends BaseState<List<OrderServiceModel>> {
  CartServiceState({
    bool isLoading = false,
    bool isError = false,
    List<OrderServiceModel>? data,
    String? message,
  }) : super(
            isLoading: isLoading,
            isError: isError,
            data: data,
            message: message);

  factory CartServiceState.initial() {
    return CartServiceState();
  }

  factory CartServiceState.loading() {
    return CartServiceState(isLoading: true);
  }

  factory CartServiceState.success(List<OrderServiceModel> data) {
    return CartServiceState(data: data);
  }

  factory CartServiceState.error(String message) {
    return CartServiceState(isError: true, message: message);
  }
}
