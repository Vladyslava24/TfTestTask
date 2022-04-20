import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:force_upgrade_service/service.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/common/flavor/flavor_config.dart';
import 'package:totalfit/di/application_dependencies_module_resolver.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/redux/store.dart';
import 'package:totalfit/ui/route/app_route.dart';
import 'package:totalfit/ui/widgets/keys.dart';
import 'package:ui_kit/ui_kit.dart';
import 'common/app_lifecycle_observer.dart';
import 'common/flavor/flavor_banner.dart';
import 'ui/utils/notification_helper.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;

class TotalFitApp extends StatefulWidget {
  final FlavorConfig flavorConfig;

  TotalFitApp(this.flavorConfig);

  @override
  _TotalFitAppState createState() => _TotalFitAppState();
}

class _TotalFitAppState extends State<TotalFitApp> {
  Future<Store<AppState>> _store;

  @override
  void initState() {
    Future.microtask(() async {
      notificationAppLaunchDetails = await flutterLocalNotificationsPlugin
          .getNotificationAppLaunchDetails();
      initNotifications(flutterLocalNotificationsPlugin);
    });

    TFLogger logger = TFLogger();

    ApplicationDependenciesModuleResolver.register(widget.flavorConfig, logger);

    _store = createStore(flavorConfig: widget.flavorConfig, logger: logger);

    if (FlavorConfig.isDev()) {
      final NavigationHistoryObserver historyObserver =
          NavigationHistoryObserver();

      historyObserver.historyChangeStream.listen((change) {
        print('historyObserver: ${historyObserver.history}');
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return _addFlavorFlag(
      FutureBuilder(
          future: _store,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
              }
              return Container();
            }
            return StoreProvider<AppState>(
              store: snapshot.data,
              child: ReduxAppLifecycleObserver(
                child: MaterialApp(
                    title: 'Totalfit',
                    theme: createAppTheme(),
                    debugShowCheckedModeBanner: false,
                    navigatorKey: Keys.navigatorKey,
                    initialRoute: AppRoute.SPLASH_INITIAL,
                    localizationsDelegates: [
                      ...DependencyProvider.get<
                          List<LocalizationsDelegate<dynamic>>>(),
                    ],
                    supportedLocales: [const Locale('en')],
                    navigatorObservers: FlavorConfig.isDev()
                        ? [NavigationHistoryObserver()]
                        : [],
                    onGenerateInitialRoutes: (name) => [
                          DependencyProvider.get<NavigationGraph>()
                              .getRoute(RouteSettings(name: name))
                        ],
                    onGenerateRoute:
                        DependencyProvider.get<NavigationGraph>().getRoute),
              ),
            );
          }),
    );
  }

  Widget _addFlavorFlag(Widget child) {
    if (FlavorConfig.isProd()) {
      return child;
    }
    return FlavorBanner(
        child: child,
        color: AppColorScheme.colorYellow,
        bannerLocation: BannerLocation.bottomEnd);
  }
}
