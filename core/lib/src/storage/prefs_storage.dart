import 'package:shared_preferences/shared_preferences.dart';

class PrefsStorage {
  late final SharedPreferences _prefs;

  PrefsStorage() {
    initialize();
  }

  initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs => _prefs;
}