import 'package:core/core.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';
import 'package:totalfit/exception/tf_exception.dart';


class ClearEditProfileExceptionAction {}

class ShowEditProfileLoadingAction {
  bool isLoading;

  ShowEditProfileLoadingAction(this.isLoading);
}

class ShowUserProfileAction {
  User user;

  ShowUserProfileAction(this.user);
}

class OnEditProfileErrorAction {
  final TfException error;

  OnEditProfileErrorAction(this.error);
}

class LogoutAction extends TrackableAction {
  @override
  Event event() => Event.LOGOUT;

}
