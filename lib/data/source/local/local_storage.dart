import 'package:core/core.dart';

abstract class LocalStorage {
  Future<User> insertUser(User user);

  Future<void> updateUser(User user);

  Future<User> getUserByEmail(String email);

  Future<User> getAuthenticatedUser();

  Future<int> deleteUser(User user);

  Future<List<User>> getUsers();
}
