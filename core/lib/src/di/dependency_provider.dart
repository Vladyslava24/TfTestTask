import 'package:get_it/get_it.dart';

class DependencyProvider {
  static final GetIt _di = GetIt.instance;

  static bool isRegistered<T extends Object>({Object? instance, String? instanceName}) {
    return _di.isRegistered(instance: instance, instanceName: instanceName);
  }

  static T get<T extends Object>({String? instanceName}) {
    return _di.get<T>(instanceName: instanceName);
  }

  static void registerSingleton<T extends Object>(T instance, {String? instanceName}) {
    _di.registerSingleton(instance, instanceName: instanceName);
  }

  static void registerLazySingleton<T extends Object>(T Function() factory, {String? instanceName}) {
    _di.registerLazySingleton(factory, instanceName: instanceName);
  }

  static void registerFactory<T extends Object>(T Function() factory, {String? instanceName}) {
    _di.registerFactory(factory, instanceName: instanceName);
  }
}
