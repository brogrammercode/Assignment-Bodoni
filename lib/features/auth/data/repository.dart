import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedplan/core/config/exception.dart';

import 'model.dart';

class AuthRepository {
  static File? _dbFile;
  static final String UID_KEY = "uid";

  static Future<void> _init() async {
    if (_dbFile != null) return;

    final dir = await getApplicationDocumentsDirectory();
    _dbFile = File('${dir.path}/users.json');

    if (!await _dbFile!.exists()) {
      await _dbFile!.writeAsString(json.encode([]));
    }
  }

  Future<void> setId({required String id}) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(UID_KEY, id);
  }

  Future<String?> getId() async {
    final sp = await SharedPreferences.getInstance();
    return await sp.getString(UID_KEY);
  }

  static Future<List<User>> _readAll() async {
    await _init();
    final contents = await _dbFile!.readAsString();
    final data = json.decode(contents) as List<dynamic>;
    return data.map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
  }

  static Future<void> _writeAll({List<User> users = const []}) async {
    await _init();
    final data = users.map((u) => u.toJson()).toList();
    await _dbFile!.writeAsString(json.encode(data));
  }

  Future<User> create({required User user}) async {
    try {
      final users = await _readAll();
      if (users.any((u) => u.email == user.email || u.id == user.id)) {
        throw CacheException("User already exists with same email/id");
      }
      users.add(user);
      await _writeAll(users: users);
      return user;
    } catch (e) {
      throw CacheException("CREATE ERROR: $e");
    }
  }

  Future<User?> read({String? email, String? id}) async {
    try {
      final users = await _readAll();
      final user = users.firstWhere(
        (u) =>
            (email != null && u.email == email) || (id != null && u.id == id),
      );
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<User> update({
    String? email,
    String? id,
    required User newUser,
  }) async {
    try {
      final users = await _readAll();
      final index = users.indexWhere(
        (u) =>
            (email != null && u.email == email) || (id != null && u.id == id),
      );

      if (index == -1) throw CacheException("User not found");

      users[index] = newUser;
      await _writeAll(users: users);
      return newUser;
    } catch (e) {
      throw CacheException("UPDATE ERROR: $e");
    }
  }

  Future<void> delete({String? email, String? id}) async {
    try {
      final users = await _readAll();
      users.removeWhere(
        (u) =>
            (email != null && u.email == email) || (id != null && u.id == id),
      );
      await _writeAll(users: users);
    } catch (e) {
      throw CacheException("DELETE ERROR: $e");
    }
  }
}
