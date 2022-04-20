import 'package:core/core.dart';
import 'package:profile_data/src/repository/profile_repository.dart';
import 'package:profile_data/src/repository/profile_repository_impl.dart';

class ProfileDataDependencyResolver {
  static void register() {
    DependencyProvider.registerLazySingleton<ProfileRepository>(() =>
        ProfileRepositoryImpl(
            DependencyProvider.get<NetworkClient>(),
            DependencyProvider.get<JwtProvider>(),
            DependencyProvider.get<TFLogger>()));
  }
}
