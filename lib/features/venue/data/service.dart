import 'dart:developer';

import 'package:wedplan/core/utils/formatter.dart';
import 'package:wedplan/features/venue/data/model.dart';
import 'package:wedplan/features/venue/data/repository.dart';

class VenueService {
  final repo = VenueRepository();
  final formatter = Formatter();

  Future<Venue> createVenue({required Venue venue}) async {
    try {
      if (venue.price < 0 || venue.capacity <= 0) {
        throw Exception("Invalid venue details");
      }
      final created = await repo.create(venue: venue);
      return created;
    } catch (e) {
      log("CREATE VENUE ERROR: $e");
      throw Exception(e);
    }
  }

  Future<Venue> getVenueById({required String id}) async {
    try {
      final venue = await repo.read(id: id);
      if (venue != null) {
        return venue;
      } else {
        throw Exception("Venue not found");
      }
    } catch (e) {
      log("GET VENUE ERROR: $e");
      throw Exception("Venue not found");
    }
  }

  Future<List<Venue>> getAllVenues() async {
    try {
      return await repo.readAll();
    } catch (e) {
      log("GET ALL VENUES ERROR: $e");
      throw Exception("Failed to fetch venues");
    }
  }

  Future<Venue> updateVenue({required String id, required Venue venue}) async {
    try {
      final updated = await repo.update(id: id, newVenue: venue);
      return updated;
    } catch (e) {
      log("UPDATE VENUE ERROR: $e");
      throw Exception(e);
    }
  }

  Future<void> deleteVenue({required String id}) async {
    try {
      await repo.delete(id: id);
    } catch (e) {
      log("DELETE VENUE ERROR: $e");
      throw Exception(e);
    }
  }

  Future<List<Venue>> searchByCity({required String city}) async {
    try {
      final venues = await repo.readAll();
      return venues
          .where((v) => v.location.city.toLowerCase() == city.toLowerCase())
          .toList();
    } catch (e) {
      log("SEARCH VENUE BY CITY ERROR: $e");
      return [];
    }
  }

  Future<List<Venue>> filterByPriceRange({
    required num min,
    required num max,
  }) async {
    try {
      final venues = await repo.readAll();
      return venues.where((v) => v.price >= min && v.price <= max).toList();
    } catch (e) {
      log("FILTER VENUE ERROR: $e");
      return [];
    }
  }

  Future<List<Venue>> filterByCapacity({required num minCapacity}) async {
    try {
      final venues = await repo.readAll();
      return venues.where((v) => v.capacity >= minCapacity).toList();
    } catch (e) {
      log("FILTER CAPACITY ERROR: $e");
      return [];
    }
  }
}
