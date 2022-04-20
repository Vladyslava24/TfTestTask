import 'dart:io';

import 'package:core/core.dart';
import 'package:force_upgrade_data/data.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ui/ui.dart';
import 'package:version/version.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class ForceUpgradeService {
  late UpgradeRepository _repository;
  late AppNavigator _navigator;
  late TFLogger _logger;

  ForceUpgradeService(
      AppNavigator navigator, RemoteConfig remoteConfig, TFLogger logger) {
    _navigator = navigator;
    _logger = logger;
    _repository =
        Platform.isIOS ? IosUpgradeRepository() : AndroidUpgradeRepository();

    remoteConfig
        .setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 1),
          minimumFetchInterval: Duration.zero,
        ))
        .then((value) => remoteConfig.fetchAndActivate())
        .then((value) => remoteConfig
            .setDefaults(<String, dynamic>{'chekForceUpgrade': false}))
        .then((value) {
      if (remoteConfig.getBool('chekForceUpgrade')) {
        checkForUpgrade();
      }
    });
  }

  void checkForUpgrade() async {
    _logger.logDebug('ForceUpgradeService. checkForUpgrade');
    try {
      final packageInfo = await PackageInfo.fromPlatform();

      final response =
          await _repository.checkForUpgrade(packageInfo.packageName);
      _logger.logDebug('ForceUpgradeService. $response');
      final currentVersion = Version.parse(packageInfo.version);

      if (response.storeVersion != null) {
        if ((response.storeVersion! > currentVersion &&
            response.storeListingUrl != null)) {
          UpgradeVersionScreen.show(response.storeListingUrl!, _navigator);
        }
      }
    } catch (e) {
      _logger.logError(e.toString());
    }
  }
}
