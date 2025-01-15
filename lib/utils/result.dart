final class Result<T> {
  final bool isSuccess;
  final T? value;
  final String? error;

  Result({
    required this.isSuccess,
    required this.value,
    required this.error,
  });

  static ok<T>(T value) {
    return Result(isSuccess: true, value: value, error: null);
  }

  static err<T>(String error) {
    return Result(isSuccess: false, value: null, error: error);
  }
}