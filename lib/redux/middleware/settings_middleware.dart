import 'dart:io';

import 'package:core/core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/storage/file/file_helper.dart';
import 'package:totalfit/storage/file/file_size_util.dart';
import 'package:totalfit/redux/actions/settings_actions.dart';

List<Middleware<AppState>> settingsMiddleware(SharedPreferences prefs, TFLogger logger) {
  final clearStorageAction = _onClearStorageAction(prefs, logger);
  final onFetchVideoStorageSizeAction = _onFetchVideoStorageSizeAction(logger);

  return [
    TypedMiddleware<AppState, FetchVideoStorageSizeAction>(onFetchVideoStorageSizeAction),
    TypedMiddleware<AppState, ClearStorageAction>(clearStorageAction),
  ];
}

Middleware<AppState> _onClearStorageAction(SharedPreferences prefs, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _onClearStorageAction");

    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final videoDirectory = Directory("${documentsDirectory.path}/$VIDEO_DIRECTORY");
      if (await videoDirectory.exists()) {
        await videoDirectory.delete(recursive: true);
      }

      //TODO: Add Actual Dependency

      //DependencyProvider.get<DownloadVideoService>().clearCache();

      next(UpdateWorkoutAfterClearCacheAction());
      next(UpdateVideoStorageSizeAction("0 MB"));
    } catch (e) {
      logger.logError("$action _onClearStorageAction ${e.toString()}");
      next(ErrorReportAction(where: "storage_middleware", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

Middleware<AppState> _onFetchVideoStorageSizeAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _onFetchVideoStorageSizeAction");

    try {
      int size = 0;
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final videoDirectory = Directory("${documentsDirectory.path}/$VIDEO_DIRECTORY");

      if (videoDirectory.existsSync()) {
        videoDirectory.listSync(recursive: true, followLinks: false).forEach((FileSystemEntity entity) {
          if (entity.existsSync()) {
            final stat = entity.statSync();
            size += stat.size;
          }
        });
      }
      next(UpdateVideoStorageSizeAction(size == 0 ? "0 MB" : fileSize(size)));
    } catch (e) {
      logger.logError("$action _onFetchVideoStorageSizeAction ${e.toString()}");
      next(ErrorReportAction(where: "storage_middleware", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}
