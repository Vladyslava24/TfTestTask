import 'dart:io';

import 'package:core/core.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:totalfit/data/source/local/local_storage.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';


class LocalStorageImpl implements LocalStorage {
  static Database _db;

  static Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await _initDB();
    }
    return _db;
  }

  static Future _initDB() async {
    Directory path = await getApplicationDocumentsDirectory();
    String dbPath = join(path.path, "tf.db");
    var db = await openDatabase(dbPath, version: 3, onCreate: _create);
    return db;
  }

  static Future _create(Database db, int version) async {
    await db.execute("CREATE TABLE ${User.table_name} ("
        "${User.field_email} TEXT NOT NULL PRIMARY KEY, "
        "${User.field_first_name} TEXT NOT NULL, "
        "${User.field_last_name} TEXT, "
        "${User.field_photo} TEXT, "
        "${User.field_birthday} TEXT, "
        "${User.field_register_date} TEXT, "
        "${User.field_status} TEXT, "
        "${User.field_token} TEXT, "
        "${User.field_verify_email_sent} TEXT, "
        "${User.field_height} TEXT, "
        "${User.field_weight} TEXT, "
        "${User.field_country} TEXT, "
        "${User.field_city} TEXT, "
        "${User.field_gender} TEXT, "
        "${User.field_roles} TEXT NOT NULL)"
        "");
  }

  Future<User> insertUser(User user) async {
    var dbClient = await db;
    try {
      await dbClient.insert(User.table_name, user.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print("Failure: Not Inserted to Storage, reason:  ${e.toString()}");
      throw e;
    }
    print("Succesls: Inserted to Storage $user");
    return user;
  }

  Future<void> updateUser(User user) async {
    var dbClient = await db;
    await dbClient.update(
      User.table_name,
      user.toJson(),
      where: "${User.field_email} = ?",
      whereArgs: [user.email],
    );
  }

  Future<User> getUserByEmail(String email) async {
    var dbClient = await db;
    final List<Map<String, dynamic>> result = await dbClient.query(
      User.table_name,
      where: "${User.field_email} = ?",
      whereArgs: [email],
    );

    if (result.isEmpty) {
      return null;
    }

    User user = User.fromJson(result[0]);
    return user;
  }

  Future<User> getAuthenticatedUser() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> result =
        await dbClient.query(User.table_name);

    if (result.length == 0) {
      throw TfException(
          ErrorCode.ERROR_NO_AUTHORIZED_USER, "ERROR_NO_AUTHORIZED_USER");
    }

    if (result.length > 1) {
      throw TfException(ErrorCode.ERROR_ILLEGAL_AUTHORIZED_USER_NUMBER,
          "ERROR_ILLEGAL_AUTHORIZED_USER_NUMBER");
    }

    User user = User.fromJson(result[0]);
    return user;
  }

  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    final result = await dbClient.delete("${User.table_name}",
        where: "${User.field_email} = ?", whereArgs: [user.email]);

    if (result == 0) {
      print("Failure: $user was not deleted");
    }
    return result;
  }

  Future<List<User>> getUsers() async {
    var dbClient = await db;
    final List<Map<String, dynamic>> maps =
        await dbClient.query(User.table_name);
    return List.generate(maps.length, (i) {
      return User.fromJson(maps[i]);
    });
  }
}
