import '../../../shared/entities/location.dart';
import '../../venue/data/model.dart';

class Wedding {
  final String id;
  final String name;
  final DateTime td;
  final Location location;
  final Venue venue;
  final bool photography;
  final bool catering;
  final bool mehendi;
  final bool sangeet;
  final bool honeymoon;
  final String createdBy;
  final DateTime creationTd;

  const Wedding({
    required this.id,
    required this.name,
    required this.td,
    required this.location,
    required this.venue,
    required this.photography,
    required this.catering,
    required this.mehendi,
    required this.sangeet,
    required this.honeymoon,
    required this.createdBy,
    required this.creationTd,
  });

  factory Wedding.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('JSON cannot be null');
    }

    return Wedding(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      td: DateTime.tryParse(json['td']?.toString() ?? '') ?? DateTime(1970),
      location: json['location'] != null
          ? Location.fromJson(json['location'] as Map<String, dynamic>?)
          : const Location(
              area: '',
              city: '',
              state: '',
              country: '',
              pincode: 0,
            ),
      venue: json['venue'] != null
          ? Venue.fromJson(json['venue'] as Map<String, dynamic>?)
          : const Venue(
              id: '',
              images: [],
              name: '',
              description: '',
              location: Location(
                area: '',
                city: '',
                state: '',
                country: '',
                pincode: 0,
              ),
              price: 0,
              capacity: 0,
            ),
      photography: json['photography'] as bool? ?? false,
      catering: json['catering'] as bool? ?? false,
      mehendi: json['mehendi'] as bool? ?? false,
      sangeet: json['sangeet'] as bool? ?? false,
      honeymoon: json['honeymoon'] as bool? ?? false,
      createdBy: json['createdBy'] as String? ?? '',
      creationTd:
          DateTime.tryParse(json['creationTd']?.toString() ?? '') ??
          DateTime(1970),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'td': td.toIso8601String(),
      'location': location.toJson(),
      'venue': venue.toJson(),
      'photography': photography,
      'catering': catering,
      'mehendi': mehendi,
      'sangeet': sangeet,
      'honeymoon': honeymoon,
      'createdBy': createdBy,
      'creationTd': creationTd.toIso8601String(),
    };
  }

  Wedding copyWith({
    String? id,
    String? name,
    DateTime? td,
    Location? location,
    Venue? venue,
    bool? photography,
    bool? catering,
    bool? mehendi,
    bool? sangeet,
    bool? honeymoon,
    String? createdBy,
    DateTime? creationTd,
  }) {
    return Wedding(
      id: id ?? this.id,
      name: name ?? this.name,
      td: td ?? this.td,
      location: location ?? this.location,
      venue: venue ?? this.venue,
      photography: photography ?? this.photography,
      catering: catering ?? this.catering,
      mehendi: mehendi ?? this.mehendi,
      sangeet: sangeet ?? this.sangeet,
      honeymoon: honeymoon ?? this.honeymoon,
      createdBy: createdBy ?? this.createdBy,
      creationTd: creationTd ?? this.creationTd,
    );
  }

  @override
  String toString() {
    return 'Wedding(id: $id, name: $name, td: $td, location: $location, venue: $venue, photography: $photography, catering: $catering, mehendi: $mehendi, sangeet: $sangeet, honeymoon: $honeymoon, createdBy: $createdBy, creationTd: $creationTd)';
  }
}
