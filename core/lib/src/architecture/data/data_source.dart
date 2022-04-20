abstract class DataSource<R, T> {
  Future<T?> getData(R request);
}

abstract class DataStorage<R, T> implements DataSource<R, T> {
  Future putData(T data);
}
