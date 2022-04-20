import 'package:core/core.dart';
import 'package:totalfit/data/dto/request/login_request.dart';
import 'package:totalfit/data/dto/request/password_recovery_request.dart';
import 'package:totalfit/data/dto/request/sign_in_with_social_request.dart';
import 'package:totalfit/data/dto/request/sign_up_request.dart';
import 'package:totalfit/data/dto/request/update_profile_request.dart';
import 'package:totalfit/data/source/local/local_storage.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/source/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteStorage _remoteStorage;
  final LocalStorage _localStorage;

  UserRepositoryImpl(this._remoteStorage, this._localStorage);

  @override
  Future<User> logIn(LogInRequest request) {
    return _remoteStorage.logIn(request);
  }

  @override
  Future<User> signUp(SignUpRequest request) {
    return _remoteStorage.signUp(request);
  }

  @override
  Future<void> resetPassword(String email) {
    return _remoteStorage.resetPassword(email);
  }

  @override
  Future<User> signInWithSocial(SignInWithSocialRequest request) {
    return _remoteStorage.signInWithSocial(request);
  }

  @override
  Future<void> passwordRecovery(PasswordRecoveryRequest request) {
    return _remoteStorage.passwordRecovery(request);
  }

  @override
  Future<String> updateProfile(UpdateProfileRequest body) {
    return _remoteStorage.updateProfile(body);
  }

  @override
  Future<String> uploadProfileImage(String imagePath) {
    return _remoteStorage.uploadProfileImage(imagePath);
  }

  @override
  Future<int> deleteUser(User user) {
    return _localStorage.deleteUser(user);
  }

  @override
  Future<User> getAuthenticatedUser() {
    return _localStorage.getAuthenticatedUser();
  }

  @override
  Future<User> getUserByEmail(String email) {
    return _localStorage.getUserByEmail(email);
  }

  @override
  Future<List<User>> getUsers() {
    return _localStorage.getUsers();
  }

  @override
  Future<User> insertUser(User user) {
    return _localStorage.insertUser(user);
  }

  @override
  Future<void> updateUser(User user) {
    return _localStorage.updateUser(user);
  }
}
