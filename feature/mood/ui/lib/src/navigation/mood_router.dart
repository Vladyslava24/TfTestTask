import 'package:flutter/material.dart';
import 'package:mood_ui/src/navigation/mood_route.dart';
import 'package:mood_ui/src/screen/mood_screen.dart';

class MoodRouter {
  static Map<String, Route Function(RouteSettings)> getRoutes() => _routeMap;

  static final _routeMap = {
    MoodRoute.moodScreen: (settings) =>
      MaterialPageRoute(builder: (c) => const MoodScreen(), settings: settings),
  };
}