import 'dart:math';

import 'package:core/src/architecture/data/repository.dart';

import '../data/data_source.dart';

class UserRepositoryImpl extends Repository<UserRequest, User> {
  UserRepositoryImpl(RemoteUserDataSource remoteSource, LocalUserDataSource localSource)
      : super(remoteSource: remoteSource, localSource: localSource);
}

class User {
  final String email;
  final String name;

  User({required this.email, required this.name});

  @override
  String toString() => "User. email: $email";

  @override
  int get hashCode => email.hashCode;

  @override
  bool operator ==(other) {
    if (other is! User) {
      return false;
    }
    return email == other.email;
  }
}

class UserRequest {
  final String email;

  UserRequest({required this.email});
}

class RemoteUserDataSource extends DataSource<UserRequest, User> {
  final Random _random = Random();

  @override
  Future<User> getData(UserRequest request) {
    return Future.value(remoteUsers[_random.nextInt(remoteUsers.length - 1)]);
  }
}

class LocalUserDataSource extends DataStorage<UserRequest, User> {
  final List<User> _cache = [];

  @override
  Future<User?> getData(UserRequest request) {
    User? user;
    try {
      user = _cache.firstWhere((element) => element.email == request.email);
    } catch (e) {
      user = null;
    }

    return Future.value(user);
  }

  @override
  Future putData(User data) {
    return Future(() {
      _cache.add(data);
    });
  }
}

final List<User> remoteUsers = [
  User(email: "a1@r.com", name: "user1"),
  User(email: "a2@r.com", name: "user2"),
  User(email: "a3@r.com", name: "user3"),
  User(email: "a4@r.com", name: "user4"),
  User(email: "a5@r.com", name: "user5"),
];
