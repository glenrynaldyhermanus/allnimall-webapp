import 'package:allnimall_web/src/core/utils/base_state.dart';
import 'package:allnimall_web/src/data/models/service.dart';

class ServiceProviderState extends BaseState<List<ServiceModel>> {
  ServiceProviderState({
    bool isLoading = false,
    bool isError = false,
    List<ServiceModel>? data,
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

  factory ServiceProviderState.success(List<ServiceModel> data) {
    return ServiceProviderState(data: data);
  }

  factory ServiceProviderState.error(String message) {
    return ServiceProviderState(isError: true, message: message);
  }
}
