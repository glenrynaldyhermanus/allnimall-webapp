abstract class BaseState<T> {
  final bool isLoading;
  final bool isError;
  final T? data;

  BaseState({
    this.isLoading = false,
    this.isError = false,
    this.data,
  });

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function() error,
  }) {
    if (isLoading) {
      return loading();
    } else if (isError) {
      return error();
    } else if (data != null) {
      return success(data as T);
    } else {
      return initial();
    }
  }
}
