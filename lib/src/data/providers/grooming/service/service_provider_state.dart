import 'package:allnimall_web/src/core/utils/base_state.dart';
import 'package:allnimall_web/src/data/models/service.dart';

class ServiceProviderState extends BaseState<List<Service>> {
  ServiceProviderState({
    bool isLoading = false,
    bool isError = false,
    List<Service>? data,
    String? message,
  }) : super(
            isLoading: isLoading,
            isError: isError,
            data: data,
            message: message);

  factory ServiceProviderState.initial() {
    return ServiceProviderState();
  }

  factory ServiceProviderState.loading() {
    return ServiceProviderState(isLoading: true);
  }

  factory ServiceProviderState.success(List<Service> data) {
    return ServiceProviderState(data: data);
  }

  factory ServiceProviderState.error(String message) {
    return ServiceProviderState(isError: true, message: message);
  }
}
