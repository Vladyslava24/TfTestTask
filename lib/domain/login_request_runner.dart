import 'package:core/core.dart';
import 'package:totalfit/data/dto/request/login_request.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/model/log_in_type.dart';

import '../domain/social_auth_operations.dart';

class  LoginRequestRunner {
  final LoginType request;
  final UserRepository userRepository;
  SocialSignInOperations _operations;

  LoginRequestRunner(this.request, this.userRepository) {
    _operations = SocialSignInOperations(userRepository);
  }

  // ignore: missing_return
  Future<User> login() async {
    switch (request.runtimeType) {
      case FacebookLogIn:
        return _operations.signInWithFacebook();
      case GoogleLogIn:
        return _operations.signInWithGoogle();
      case AppleLogIn:
        return _operations.signInWithApple();
      case LogInRequest:
        return _loginWithEmail(request);
    }
  }

  Future<User> _loginWithEmail(LogInRequest request) async {
    return userRepository.logIn(request);
  }
}
