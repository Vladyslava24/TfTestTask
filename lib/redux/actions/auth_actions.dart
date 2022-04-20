import 'package:core/core.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';
import 'package:totalfit/data/dto/request/login_request.dart';
import 'package:totalfit/data/dto/request/sign_in_with_social_request.dart';
import 'package:totalfit/data/dto/request/sign_up_request.dart';
import 'package:totalfit/model/log_in_type.dart';
import 'package:totalfit/model/sign_up_type.dart';
import 'package:totalfit/ui/widgets/input_field_widget.dart';

class OnUserLoginAction extends TrackableAction implements SetUserAction {
  final User user;
  final LoginType type;

  OnUserLoginAction(this.user, this.type);

  @override
  Event event() => Event.LOGIN;

  @override
  Map<String, String> parameters() {
    Map<String, String> params = {};

    if (user.email != null) {
      params["email"] = user.email;
    }

    if (type is FacebookLogIn) {
      params.putIfAbsent("type", () => "facebook");
    } else if (type is GoogleLogIn) {
      params.putIfAbsent("type", () => "google");
    } else if (type is LogInRequest) {
      params.putIfAbsent("type", () => "email");
    } else {
      params.putIfAbsent("type", () => "apple");
    }
    return params;
  }

  @override
  User getUser() => user;
}

class OnUserSignUpAction extends TrackableAction implements SetUserAction {
  final User user;
  final SignUpType type;
  final bool emailSubscription;

  OnUserSignUpAction(this.user, this.type, {this.emailSubscription = false});

  @override
  Event event() => Event.SIGN_UP;

  @override
  Map<String, String> parameters() {
    Map<String, String> params = {};
    if (user.email != null) {
      params["email"] = user.email;
    }
    if (emailSubscription != null) {
      params["emailSubscription"] = emailSubscription.toString();
    }

    if (type is FacebookSignUp) {
      params.putIfAbsent("type", () => "facebook");
    } else if (type is GoogleSignUp) {
      params.putIfAbsent("type", () => "google");
    } else if (type is SignUpRequest) {
      params.putIfAbsent("type", () => "email");
    } else if (type is SignInWithSocialRequest) {
      params.putIfAbsent("type", () => (type as SignInWithSocialRequest).provider);
    } else {
      params.putIfAbsent("type", () => "apple");
    }
    return params;
  }

  @override
  User getUser() => user;
}

class UpdateUserStateAction implements SetUserAction {
  final User user;

  UpdateUserStateAction(this.user);

  @override
  User getUser() => user;
}

class OnLoginErrorAction {
  final ApiException error;

  OnLoginErrorAction(this.error);
}

class OnSignUpErrorAction {
  final ApiException error;

  OnSignUpErrorAction(this.error);
}

class ClearSignUpExceptionAction {}

class ClearLoginExceptionAction {}

class CountryErrorAction {
  final String message;

  CountryErrorAction(this.message);
}

class ClearSignUpErrorAction {
  final InputFieldType type;

  ClearSignUpErrorAction(this.type);
}

class ClearLoginErrorAction {
  final InputFieldType type;

  ClearLoginErrorAction(this.type);
}

class ClearAllFieldErrorsAction {}

abstract class SetUserAction {
  User getUser();
}

class RetryFetchProductListAction extends SetUserAction {
  final User user;

  RetryFetchProductListAction(this.user);

  @override
  User getUser() => user;
}
