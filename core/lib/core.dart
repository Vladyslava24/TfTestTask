library core;

import 'package:core/src/always_on/always_on.dart';
import 'package:core/src/connection/connection_checker.dart';
import 'package:core/src/di/dependency_provider.dart';
import 'package:core/src/logger/tf_logger.dart';
import 'package:core/src/network_client/client/network_client.dart';
import 'package:core/src/secure/jwt_token_provider.dart';
import 'package:core/src/storage/prefs_storage.dart';
import 'package:core/src/vibrator/vibrator.dart';
import 'src/network_client/default/default_network_client.dart';

export 'src/network_client/client/network_client.dart';
export 'src/network_client/default/default_network_client.dart';
export 'src/network_client/exception/api_exception.dart';
export 'src/network_client/model/network_request.dart';
export 'src/network_client/model/network_response.dart';
export 'src/secure/jwt_token_provider.dart';
export 'src/navigation/navigation_graph.dart';
export 'src/navigation/app_navigator.dart';
export 'src/ui/bloc/base_bloc.dart';
export 'src/ui/cubit/base_cubit.dart';
export 'src/ui/page/base_page.dart';
export 'src/di/dependency_provider.dart';
export 'src/utils/string_utils.dart';
export 'src/utils/enum_utils.dart';
export 'src/utils/date_utils.dart';
export 'generated/l10n.dart';
export 'src/storage/prefs_storage.dart';
export 'src/vibrator/vibrator.dart';
export 'src/utils/result.dart';
export 'src/audio/service/audio_service.dart';
export 'src/logger/tf_logger.dart';
export 'src/always_on/always_on.dart';
export 'src/entity/user.dart';

class CoreModuleInitializer {
  static void init(String baseUrl, TFLogger logger) {
    DependencyProvider.registerLazySingleton<JwtProvider>(() => JwtProvider());
    DependencyProvider.registerLazySingleton<NetworkClient>(() => DefaultHttpClient(baseUrl, logger));
    DependencyProvider.registerLazySingleton<ConnectionChecker>(() => ConnectionChecker(logger));
    DependencyProvider.registerSingleton<PrefsStorage>(PrefsStorage());
    DependencyProvider.registerLazySingleton<Vibrator>(() => Vibrator());
    DependencyProvider.registerLazySingleton<AlwaysOn>(() => AlwaysOn());
  }
}
