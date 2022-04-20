import 'package:core/core.dart';
import 'package:profile_data/data.dart';
import 'package:profile_ui/profile.dart';

class ProfileDependencyResolver {
  static void register() {
    ProfileDataDependencyResolver.register();

    DependencyProvider.registerLazySingleton<ProfileUseCase>(
        () => ProfileUseCase(DependencyProvider.get<ProfileRepository>()));

    DependencyProvider.registerLazySingleton<ProfileCubit>(() => ProfileCubit(
        DependencyProvider.get<ProfileUseCase>(),
        DependencyProvider.get<TFLogger>()));
  }
}
