class Result<T> {
  factory Result.success(T data) => Result._(loading: false, content: data);

  factory Result.error(Object error) => Result._(loading: false, error: error);

  factory Result.loading(T? data) => Result._(loading: true, content: data);

  bool isSuccess() => !isLoading() && !isError() && content != null;

  bool isError() => error != null;

  bool isLoading() => loading;

  final bool loading;
  final T? content;
  final Object? error;

  Result._({this.loading = false, this.content, this.error});

  @override
  String toString() {
    if (isSuccess()) {
      return 'Success: $content';
    } else if (isError()) {
      return 'Error: $error';
    } else {
      return 'Loading: $content';
    }
  }
}