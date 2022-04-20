import 'package:flutter/material.dart';
import 'package:core/generated/l10n.dart';

class LocalesService {
  LocalesService(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;

  S get locales => S.of(navigatorKey.currentContext);
}
