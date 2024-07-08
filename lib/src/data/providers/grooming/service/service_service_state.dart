import 'package:allnimall_web/src/core/utils/base_state.dart';
import 'package:allnimall_web/src/data/models/service.dart';

class ServiceServiceState extends BaseState<List<ServiceModel>> {
  ServiceServiceState({
    bool isLoading = false,
    bool isError = false,
    List<ServiceModel>? data,
    String? message,
  }) : super(
            isLoading: isLoading,
            isError: isError,
            data: data,
            message: message);

  factory ServiceServiceState.initial() {
    return ServiceServiceState();
  }

  factory ServiceServiceState.loading() {
    return ServiceServiceState(isLoading: true);
  }

  factory ServiceServiceState.success(List<ServiceModel> data) {
    return ServiceServiceState(data: data);
  }

  factory ServiceServiceState.error(String message) {
    return ServiceServiceState(isError: true, message: message);
  }
}
