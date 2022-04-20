import 'data_delegate.dart';
import 'data_source.dart';

abstract class Repository<R, T> {
  final DataSource<R, T> remoteSource;
  final DataStorage<R, T> localSource;
  late DataDelegate<T> _dataDelegate;

  Repository({required this.remoteSource, required this.localSource}) {
    _dataDelegate = DataDelegate(
      putToCache: (data) => localSource.putData(data),
      getFromCache: (request) => localSource.getData(request),
      getFromRemote: (request) => remoteSource.getData(request),
    );
  }

  Stream<Result<T>> get(R request, bool force) {
    return _dataDelegate.observe(request, force);
  }
}
