part of 'wedding_cubit.dart';

class WeddingState extends Equatable {
  final List<Wedding> weddings;
  final Wedding? selectedWedding;
  final AppStatus fetchStatus;
  final AppStatus createStatus;
  final AppStatus updateStatus;
  final AppStatus deleteStatus;
  final String? error;

  const WeddingState({
    this.weddings = const [],
    this.selectedWedding,
    this.fetchStatus = AppStatus.initial,
    this.createStatus = AppStatus.initial,
    this.updateStatus = AppStatus.initial,
    this.deleteStatus = AppStatus.initial,
    this.error,
  });

  WeddingState copyWith({
    List<Wedding>? weddings,
    Wedding? selectedWedding,
    AppStatus? fetchStatus,
    AppStatus? createStatus,
    AppStatus? updateStatus,
    AppStatus? deleteStatus,
    String? error,
  }) {
    return WeddingState(
      weddings: weddings ?? this.weddings,
      selectedWedding: selectedWedding ?? this.selectedWedding,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      createStatus: createStatus ?? this.createStatus,
      updateStatus: updateStatus ?? this.updateStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    weddings,
    selectedWedding,
    fetchStatus,
    createStatus,
    updateStatus,
    deleteStatus,
    error,
  ];
}
