import 'dart:developer';

import 'package:wedplan/core/utils/formatter.dart';
import 'package:wedplan/features/weeding/data/repository.dart';

import 'model.dart';

class WeddingService {
  final repo = WeddingRepository();
  final formatter = Formatter();

  Future<Wedding> createWedding({required Wedding wedding}) async {
    try {
      if (wedding.venue.capacity <= 0 || wedding.venue.price < 0) {
        throw Exception("Invalid wedding venue details");
      }
      if (wedding.createdBy.isEmpty) {
        throw Exception("Wedding must have a creator");
      }
      final created = await repo.create(wedding: wedding);
      return created;
    } catch (e) {
      log("CREATE WEDDING ERROR: $e");
      throw Exception(e);
    }
  }

  Future<Wedding> getWeddingById({required String id}) async {
    try {
      final wedding = await repo.read(id: id);
      if (wedding != null) {
        return wedding;
      } else {
        throw Exception("Wedding not found");
      }
    } catch (e) {
      log("GET WEDDING ERROR: $e");
      throw Exception("Wedding not found");
    }
  }

  Future<List<Wedding>> getAllWeddings() async {
    try {
      return await repo.readAll();
    } catch (e) {
      log("GET ALL WEDDINGS ERROR: $e");
      throw Exception("Failed to fetch weddings");
    }
  }

  Future<Wedding> updateWedding({
    required String id,
    required Wedding wedding,
  }) async {
    try {
      final updated = await repo.update(id: id, newWedding: wedding);
      return updated;
    } catch (e) {
      log("UPDATE WEDDING ERROR: $e");
      throw Exception(e);
    }
  }

  Future<void> deleteWedding({required String id}) async {
    try {
      await repo.delete(id: id);
    } catch (e) {
      log("DELETE WEDDING ERROR: $e");
      throw Exception(e);
    }
  }

  Future<List<Wedding>> getWeddingsByCreator(String creatorId) async {
    try {
      return await repo.findByCreator(creatorId);
    } catch (e) {
      log("GET WEDDINGS BY CREATOR ERROR: $e");
      return [];
    }
  }

  Future<List<Wedding>> getWeddingsByDateRange({
    required DateTime start,
    required DateTime end,
  }) async {
    try {
      return await repo.findByDateRange(start, end);
    } catch (e) {
      log("GET WEDDINGS BY DATE RANGE ERROR: $e");
      return [];
    }
  }

  Future<List<Wedding>> getWeddingsByServices({
    bool? photography,
    bool? catering,
    bool? mehendi,
    bool? sangeet,
    bool? honeymoon,
  }) async {
    try {
      return await repo.findByService(
        photography: photography,
        catering: catering,
        mehendi: mehendi,
        sangeet: sangeet,
        honeymoon: honeymoon,
      );
    } catch (e) {
      log("GET WEDDINGS BY SERVICES ERROR: $e");
      return [];
    }
  }
}
