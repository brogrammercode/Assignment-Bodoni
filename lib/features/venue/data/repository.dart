import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:wedplan/core/config/exception.dart';

import 'model.dart';

class VenueRepository {
  static File? _dbFile;

  static Future<void> _init() async {
    if (_dbFile != null) return;

    final dir = await getApplicationDocumentsDirectory();
    _dbFile = File('${dir.path}/venues.json');

    if (!await _dbFile!.exists()) {
      await _dbFile!.writeAsString(json.encode([]));
    }
  }

  static Future<List<Venue>> _readAll() async {
    await _init();
    final contents = await _dbFile!.readAsString();
    final data = json.decode(contents) as List<dynamic>;
    return data.map((e) => Venue.fromJson(e as Map<String, dynamic>)).toList();
  }

  static Future<void> _writeAll({List<Venue> venues = const []}) async {
    await _init();
    final data = venues.map((v) => v.toJson()).toList();
    await _dbFile!.writeAsString(json.encode(data));
  }

  Future<Venue> create({required Venue venue}) async {
    try {
      final venues = await _readAll();
      if (venues.any((v) => v.id == venue.id)) {
        throw CacheException("Venue already exists with same id");
      }
      venues.add(venue);
      await _writeAll(venues: venues);
      return venue;
    } catch (e) {
      throw CacheException("CREATE ERROR: $e");
    }
  }

  Future<Venue?> read({required String id}) async {
    try {
      final venues = await _readAll();
      return venues.firstWhere((v) => v.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Venue>> readAll() async {
    try {
      return await _readAll();
    } catch (e) {
      throw CacheException("READ ALL ERROR: $e");
    }
  }

  Future<Venue> update({required String id, required Venue newVenue}) async {
    try {
      final venues = await _readAll();
      final index = venues.indexWhere((v) => v.id == id);

      if (index == -1) throw CacheException("Venue not found");

      venues[index] = newVenue;
      await _writeAll(venues: venues);
      return newVenue;
    } catch (e) {
      throw CacheException("UPDATE ERROR: $e");
    }
  }

  Future<void> delete({required String id}) async {
    try {
      final venues = await _readAll();
      venues.removeWhere((v) => v.id == id);
      await _writeAll(venues: venues);
    } catch (e) {
      throw CacheException("DELETE ERROR: $e");
    }
  }
}
