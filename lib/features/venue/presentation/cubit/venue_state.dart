part of 'venue_cubit.dart';

class VenueState extends Equatable {
  final List<Venue> venues;
  final Venue? selectedVenue;
  final AppStatus fetchStatus;
  final AppStatus createStatus;
  final AppStatus updateStatus;
  final AppStatus deleteStatus;
  final String? error;

  const VenueState({
    this.venues = const [],
    this.selectedVenue,
    this.fetchStatus = AppStatus.initial,
    this.createStatus = AppStatus.initial,
    this.updateStatus = AppStatus.initial,
    this.deleteStatus = AppStatus.initial,
    this.error,
  });

  VenueState copyWith({
    List<Venue>? venues,
    Venue? selectedVenue,
    AppStatus? fetchStatus,
    AppStatus? createStatus,
    AppStatus? updateStatus,
    AppStatus? deleteStatus,
    String? error,
  }) {
    return VenueState(
      venues: venues ?? this.venues,
      selectedVenue: selectedVenue ?? this.selectedVenue,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      createStatus: createStatus ?? this.createStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    venues,
    selectedVenue,
    fetchStatus,
    createStatus,
    updateStatus,
    deleteStatus,
    error,
  ];
}
