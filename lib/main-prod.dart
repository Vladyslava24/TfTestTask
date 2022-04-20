import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:totalfit/common/flavor/flavor_config.dart';
import 'common/flavor/flavor.dart';
import 'totalfit_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prodConfig = FlavorConfig(flavor: Flavor.PROD, name: "Prod", values: FlavorValues(apiUrl: 'totalfit.team'));

  runZonedGuarded(() async {
    await SentryFlutter.init(
      (options) {
        options.dsn = 'https://07d51047d2df4c7eb8dc5860f7ce65e3@o1190253.ingest.sentry.io/6311292';
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(TotalFitApp(prodConfig)),
    );
  }, (exception, stackTrace) async {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  );
}