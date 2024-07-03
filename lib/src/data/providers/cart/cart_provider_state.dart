import 'package:allnimall_web/src/core/utils/base_state.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';

class CartProviderState extends BaseState<List<OrderServiceModel>> {
  CartProviderState({
    bool isLoading = false,
    bool isError = false,
    List<OrderServiceModel>? data,
    String? message,
  }) : super(
            isLoading: isLoading,
            isError: isError,
            data: data,
            message: message);

  factory CartProviderState.initial() {
    return CartProviderState();
  }

  factory CartProviderState.loading() {
    return CartProviderState(isLoading: true);
  }

  factory CartProviderState.success(List<OrderServiceModel> data) {
    return CartProviderState(data: data);
  }

  factory CartProviderState.error(String message) {
    return CartProviderState(isError: true, message: message);
  }
}
