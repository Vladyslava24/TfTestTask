abstract class CacheResult {}

class ErrorResult implements CacheResult {
  dynamic reason;

  ErrorResult(this.reason);

  @override
  String toString() => reason.toString();
}

class SuccessResult implements CacheResult {
  String filePath;

  SuccessResult({required this.filePath});
}
