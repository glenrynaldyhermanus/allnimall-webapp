abstract class BaseState<T> {
  final bool isLoading;
  final bool isError;
  final T? data;
  final String? message;

  BaseState({
    this.isLoading = false,
    this.isError = false,
    this.data,
    this.message,
  });

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String message) error,
  }) {
    if (isLoading) {
      return loading();
    } else if (isError) {
      return error(message ?? '');
    } else if (data != null) {
      return success(data as T);
    } else {
      return initial();
    }
  }
}
