import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:totalfit/common/flavor/flavor_config.dart';
import 'common/flavor/flavor.dart';
import 'totalfit_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prodConfig = FlavorConfig(
    flavor: Flavor.DEV,
    name: "Dev",
    values: FlavorValues(apiUrl: 'staging-01-totalfit.team')
  );

  runZonedGuarded(() async {
      await SentryFlutter.init(
        (options) {
          options.dsn = 'https://8321cffa26824affaee6b2e1ae745ffb@o1190253.ingest.sentry.io/6311311';
          options.tracesSampleRate = 1.0;
        },
        appRunner: () => runApp(TotalFitApp(prodConfig)),
      );
    },
    (exception, stackTrace) async {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  );
}
