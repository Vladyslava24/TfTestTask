import 'package:core/core.dart';
import 'package:totalfit/data/dto/request/login_request.dart';
import 'package:totalfit/data/dto/request/password_recovery_request.dart';
import 'package:totalfit/data/dto/request/sign_in_with_social_request.dart';
import 'package:totalfit/data/dto/request/sign_up_request.dart';
import 'package:totalfit/data/dto/request/update_profile_request.dart';


abstract class UserRepository {
  ///remote

  Future<User> logIn(LogInRequest request);

  Future<User> signUp(SignUpRequest request);

  Future<void> resetPassword(String email);

  Future<User> signInWithSocial(SignInWithSocialRequest request);

  Future<void> passwordRecovery(PasswordRecoveryRequest request);

  Future<String> updateProfile(UpdateProfileRequest body);

  Future<String> uploadProfileImage(String imagePath);

  /// local

  Future<User> insertUser(User user);

  Future<void> updateUser(User user);

  Future<User> getUserByEmail(String email);

  Future<User> getAuthenticatedUser();

  Future<int> deleteUser(User user);

  Future<List<User>> getUsers();
}
