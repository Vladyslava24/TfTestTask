import 'package:core/core.dart';
import 'package:profile_ui/profile.dart';

class ProfileUiProvider {
  static ProfileScreen getScreen(User user) {
    return ProfileScreen(user: user);
  }
}