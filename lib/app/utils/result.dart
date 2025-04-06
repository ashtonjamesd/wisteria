final class Result<T> {
  final T? value;
  final String? error;

  const Result._({this.value, this.error});

  const Result.success(T value) : this._(value: value);
  const Result.failure(String error) : this._(error: error);

  bool get isSuccess => error == null;
  bool get isFailure => error != null;
}