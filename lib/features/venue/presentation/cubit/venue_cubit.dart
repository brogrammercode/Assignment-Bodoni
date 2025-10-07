import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wedplan/core/config/exception.dart';
import 'package:wedplan/features/venue/data/model.dart';
import 'package:wedplan/features/venue/data/service.dart';

part 'venue_state.dart';

class VenueCubit extends Cubit<VenueState> {
  final service = VenueService();

  VenueCubit() : super(const VenueState());

  Future<void> fetchVenues() async {
    emit(state.copyWith(fetchStatus: AppStatus.loading));
    try {
      final venues = await service.getAllVenues();
      emit(
        state.copyWith(
          venues: venues,
          fetchStatus: AppStatus.success,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(fetchStatus: AppStatus.failed, error: e.toString()));
    }
  }

  Future<void> getVenueById(String id) async {
    emit(state.copyWith(fetchStatus: AppStatus.loading));
    try {
      final venue = await service.getVenueById(id: id);
      emit(
        state.copyWith(
          selectedVenue: venue,
          fetchStatus: AppStatus.success,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(fetchStatus: AppStatus.failed, error: e.toString()));
    }
  }

  Future<bool> createVenue(Venue venue) async {
    emit(state.copyWith(createStatus: AppStatus.loading));
    try {
      final created = await service.createVenue(venue: venue);
      final updatedList = List<Venue>.from(state.venues)..add(created);
      emit(
        state.copyWith(
          venues: updatedList,
          createStatus: AppStatus.success,
          error: null,
        ),
      );
      return true;
    } catch (e) {
      emit(state.copyWith(createStatus: AppStatus.failed, error: e.toString()));
      return false;
    }
  }

  Future<bool> updateVenue(String id, Venue venue) async {
    emit(state.copyWith(updateStatus: AppStatus.loading));
    try {
      final updated = await service.updateVenue(id: id, venue: venue);
      final updatedList = state.venues
          .map((v) => v.id == id ? updated : v)
          .toList();
      emit(
        state.copyWith(
          venues: updatedList,
          updateStatus: AppStatus.success,
          error: null,
        ),
      );
      return true;
    } catch (e) {
      emit(state.copyWith(updateStatus: AppStatus.failed, error: e.toString()));
      return false;
    }
  }

  Future<bool> deleteVenue(String id) async {
    emit(state.copyWith(deleteStatus: AppStatus.loading));
    try {
      await service.deleteVenue(id: id);
      final updatedList = state.venues.where((v) => v.id != id).toList();
      emit(
        state.copyWith(
          venues: updatedList,
          deleteStatus: AppStatus.success,
          error: null,
        ),
      );
      return true;
    } catch (e) {
      emit(state.copyWith(deleteStatus: AppStatus.failed, error: e.toString()));
      return false;
    }
  }
}
