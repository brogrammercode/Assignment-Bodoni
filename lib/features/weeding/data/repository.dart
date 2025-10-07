import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:wedplan/core/config/exception.dart';

import 'model.dart';

class WeddingRepository {
  static File? _dbFile;

  static Future<void> _init() async {
    if (_dbFile != null) return;

    final dir = await getApplicationDocumentsDirectory();
    _dbFile = File('${dir.path}/weddings.json');

    if (!await _dbFile!.exists()) {
      await _dbFile!.writeAsString(json.encode([]));
    }
  }

  static Future<List<Wedding>> _readAll() async {
    await _init();
    final contents = await _dbFile!.readAsString();
    final data = json.decode(contents) as List<dynamic>;
    return data
        .map((e) => Wedding.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> _writeAll({List<Wedding> weddings = const []}) async {
    await _init();
    final data = weddings.map((w) => w.toJson()).toList();
    await _dbFile!.writeAsString(json.encode(data));
  }

  Future<Wedding> create({required Wedding wedding}) async {
    try {
      final weddings = await _readAll();
      if (weddings.any((w) => w.id == wedding.id)) {
        throw CacheException("Wedding already exists with same id");
      }
      weddings.add(wedding);
      await _writeAll(weddings: weddings);
      return wedding;
    } catch (e) {
      throw CacheException("CREATE ERROR: $e");
    }
  }

  Future<Wedding?> read({required String id}) async {
    try {
      final weddings = await _readAll();
      return weddings.firstWhere((w) => w.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Wedding>> readAll() async {
    try {
      return await _readAll();
    } catch (e) {
      throw CacheException("READ ALL ERROR: $e");
    }
  }

  Future<Wedding> update({
    required String id,
    required Wedding newWedding,
  }) async {
    try {
      final weddings = await _readAll();
      final index = weddings.indexWhere((w) => w.id == id);

      if (index == -1) throw CacheException("Wedding not found");

      weddings[index] = newWedding;
      await _writeAll(weddings: weddings);
      return newWedding;
    } catch (e) {
      throw CacheException("UPDATE ERROR: $e");
    }
  }

  Future<void> delete({required String id}) async {
    try {
      final weddings = await _readAll();
      weddings.removeWhere((w) => w.id == id);
      await _writeAll(weddings: weddings);
    } catch (e) {
      throw CacheException("DELETE ERROR: $e");
    }
  }

  Future<List<Wedding>> findByCreator(String creatorId) async {
    final weddings = await _readAll();
    return weddings.where((w) => w.createdBy == creatorId).toList();
  }

  Future<List<Wedding>> findByDateRange(DateTime start, DateTime end) async {
    final weddings = await _readAll();
    return weddings
        .where((w) => w.td.isAfter(start) && w.td.isBefore(end))
        .toList();
  }

  Future<List<Wedding>> findByService({
    bool? photography,
    bool? catering,
    bool? mehendi,
    bool? sangeet,
    bool? honeymoon,
  }) async {
    final weddings = await _readAll();
    return weddings.where((w) {
      if (photography != null && w.photography != photography) return false;
      if (catering != null && w.catering != catering) return false;
      if (mehendi != null && w.mehendi != mehendi) return false;
      if (sangeet != null && w.sangeet != sangeet) return false;
      if (honeymoon != null && w.honeymoon != honeymoon) return false;
      return true;
    }).toList();
  }
}
