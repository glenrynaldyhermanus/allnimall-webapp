import 'package:allnimall_web/src/core/utils/base_state.dart';

class AuthServiceState extends BaseState<String> {
  AuthServiceState({
    bool isLoading = false,
    bool isError = false,
    String? data,
    String? message,
  }) : super(
            isLoading: isLoading,
            isError: isError,
            data: data,
            message: message);

  factory AuthServiceState.initial() {
    return AuthServiceState();
  }

  factory AuthServiceState.loading() {
    return AuthServiceState(isLoading: true);
  }

  factory AuthServiceState.success(String data) {
    return AuthServiceState(data: data);
  }

  factory AuthServiceState.error(String message) {
    return AuthServiceState(isError: true, message: message);
  }
}
