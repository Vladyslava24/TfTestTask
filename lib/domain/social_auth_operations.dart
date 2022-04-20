import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:totalfit/data/dto/request/sign_in_with_social_request.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';

class SocialSignInOperations {
  final UserRepository userRepository;

  SocialSignInOperations(this.userRepository);

  Future<GoogleSignInAccount> _signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/user.birthday.read',
        'https://www.googleapis.com/auth/user.emails.read',
        'https://www.googleapis.com/auth/user.gender.read',
      ],
    );

    var account;
    try {
      account = await _googleSignIn.signIn();
    } catch (e) {
      print(e);
      if (e is PlatformException && e.code == "network_error") {
        throw TfException(ErrorCode.ERROR_NETWORK, e.message);
      } else {
        throw TfException(ErrorCode.ERROR_AUTH_FAILED, e.getMessage);
      }
    }
    if (account == null) {
      throw TfException(ErrorCode.ERROR_AUTH_CANCELED, null);
    } else {
      return account;
    }
  }

  Future<AuthorizationCredentialAppleID> _signInWithApple() async {
    try {
      return await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
    } catch (e) {
      if (e is UnknownSignInWithAppleException) {
        throw TfException(ErrorCode.ERROR_AUTH_FAILED, e.message);
      } else if (e is SignInWithAppleAuthorizationException) {
        if (e.code == AuthorizationErrorCode.canceled) {
          throw TfException(ErrorCode.ERROR_AUTH_CANCELED, e.message);
        } else if (e.code == AuthorizationErrorCode.failed) {
          throw TfException(ErrorCode.ERROR_AUTH_FAILED, e.message);
        } else {
          throw TfException(ErrorCode.ERROR_AUTH_FAILED, e.message);
        }
      } else if (e is SignInWithAppleNotSupportedException) {
        throw TfException(ErrorCode.ERROR_AUTH_CANCELED, e.message);
      } else if (e is SignInWithAppleCredentialsException) {
        throw TfException(ErrorCode.ERROR_AUTH_CANCELED, e.message);
      } else {
        throw TfException(ErrorCode.ERROR_AUTH_FAILED, e.getMessage);
      }
    }
  }

  Future<LoginResult> _signInWithFacebook() async {
    final facebookLoginResult = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],

      loginBehavior: LoginBehavior.dialogOnly,
    );

    switch (facebookLoginResult.status) {
      case LoginStatus.cancelled:
        throw TfException(ErrorCode.ERROR_AUTH_CANCELED, facebookLoginResult.message);
      case LoginStatus.failed:
        throw TfException(ErrorCode.ERROR_AUTH_FAILED, facebookLoginResult.message);
      case LoginStatus.success:
        return facebookLoginResult;

      default:
        throw TfException(ErrorCode.ERROR_AUTH_CANCELED, facebookLoginResult.message);
    }
  }

  Future<User> signInWithFacebook() async {
    var result = await _signInWithFacebook();
    final request = SignInWithSocialRequest(provider: SocialType.FACEBOOK.name, accessToken: result.accessToken.token);
    final user = await userRepository.signInWithSocial(request);
    return user;
  }

  Future<User> signInWithGoogle() async {
    var result = await _signInWithGoogle();
    // Todo added in issue https://totalfit.atlassian.net/browse/TFM-542
    // Todo removed result.clearAuthCache(), if issue will be again.
    await result.clearAuthCache();
    var authentication = await result.authentication;

    final request = SignInWithSocialRequest(provider: SocialType.GOOGLE.name, accessToken: authentication.accessToken);
    final user = await userRepository.signInWithSocial(request);
    return user;
  }


  Future<User> signInWithApple() async {
    var result = await _signInWithApple();

    final request = SignInWithSocialRequest(provider: SocialType.APPLE.name, accessToken: result.identityToken);
    final user = await userRepository.signInWithSocial(request);
    return user;
  }
}
