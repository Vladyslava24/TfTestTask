import 'dart:async';
import 'package:rxdart/rxdart.dart';

class DataDelegate<T> {
  final StreamController<Result<T>> _delegateController = StreamController.broadcast();
  final Future<T?> Function(dynamic request) getFromRemote;
  final Future<T?> Function(dynamic request) getFromCache;
  final Future Function(T) putToCache;

  DataDelegate({
    required this.putToCache,
    required this.getFromCache,
    required this.getFromRemote,
  });

  Stream<Result<T>> observe(dynamic request, bool force) {
    return _forward(request, force).mergeWith([_delegateController.stream]).distinct();
  }

  Stream<Result<T>> _forward(dynamic request, bool force) async* {
    try {
      T? data = await getFromCache(request);
      yield Result.loading(data);

      if (force || data == null) {
        data = await getFromRemote(request);
        await putToCache(data!);
      }

      _delegateController.add(Result.success(data));
    } catch (e) {
      yield Result.error(e);
    }
  }

  void close() async {
    _delegateController.close();
  }
}

class Result<T> {
  factory Result.success(T? data) => Result._(data: data, loading: false);

  factory Result.loading(T? data) => Result._(data: data, loading: true);

  factory Result.error(Object error) => Result._(error: error, loading: false);

  bool isSuccess() => data != null;

  bool isError() => error != null;

  bool isLoading() => loading;

  final T? data;
  final Object? error;
  final bool loading;

  Result._({this.data, this.error, required this.loading});

  @override
  String toString() {
    if (isSuccess()) {
      return 'Success: $data';
    } else if (isError()) {
      return 'Error: $error';
    } else {
      return 'Loading';
    }
  }

  @override
  int get hashCode => data.hashCode ^ error.hashCode ^ loading.hashCode;

  @override
  bool operator ==(other) {
    if (other is! Result) {
      return false;
    }
    return data == other.data && error == other.error && loading == other.loading;
  }
}
