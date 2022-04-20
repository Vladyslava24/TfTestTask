import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtProvider {
  static const _keyJwt = "KEY_JWT";
  late final FlutterSecureStorage _secureStorage;

  JwtProvider() {
    _secureStorage = const FlutterSecureStorage();
  }

  void write(String jwt) {
    _secureStorage.write(key: _keyJwt, value: jwt);
  }

  Future<String?> read() {
    return _secureStorage.read(key: _keyJwt);
  }
}
