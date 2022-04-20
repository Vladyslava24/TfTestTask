import 'package:core/core.dart';
import 'package:totalfit/ui/route/app_route.dart';

class AppDependencyResolver {
  static void register() {
    DependencyProvider.registerSingleton(NavigationGraph());
    DependencyProvider.get<NavigationGraph>().registerFeature(AppRoute.routeMap);
  }
}
