import 'package:core/core.dart';
import 'package:totalfit/data/dto/request/sign_up_request.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/model/sign_up_type.dart';

import '../domain/social_auth_operations.dart';

class SignUpRequestRunner {
  final SignUpType type;
  final UserRepository userRepository;
  SocialSignInOperations _operations;

  SignUpRequestRunner(this.type, this.userRepository) {
    _operations = SocialSignInOperations(userRepository);
  }

  // ignore: missing_return
  Future<User> signUp() async {
    switch (type.runtimeType) {
      case GoogleSignUp:
        return _operations.signInWithGoogle();
      case AppleSignUp:
        return _operations.signInWithApple();
      case FacebookSignUp:
        return _operations.signInWithFacebook();
      case SignUpRequest:
        return _signUpWithEmail(type);
    }
  }

  Future<User> _signUpWithEmail(SignUpRequest request) async {
    return userRepository.signUp(request);
  }
}
