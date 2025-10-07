import '../../../shared/entities/location.dart';

class Venue {
  final String id;
  final List<String> images;
  final String name;
  final String description;
  final Location location;
  final num price;
  final num capacity;

  const Venue({
    required this.id,
    required this.images,
    required this.name,
    required this.description,
    required this.location,
    required this.price,
    required this.capacity,
  });

  factory Venue.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('JSON cannot be null');
    }

    return Venue(
      id: json['id'] as String? ?? '',
      images:
          (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] != null
          ? Location.fromJson(json['location'] as Map<String, dynamic>?)
          : const Location(
              area: '',
              city: '',
              state: '',
              country: '',
              pincode: 0,
            ),
      price: (json['price'] is int || json['price'] is double)
          ? json['price'] as num
          : num.tryParse(json['price']?.toString() ?? '0') ?? 0,
      capacity: (json['capacity'] is int || json['capacity'] is double)
          ? json['capacity'] as num
          : num.tryParse(json['capacity']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'images': images,
      'name': name,
      'description': description,
      'location': location.toJson(),
      'price': price,
      'capacity': capacity,
    };
  }

  Venue copyWith({
    String? id,
    List<String>? images,
    String? name,
    String? description,
    Location? location,
    num? price,
    num? capacity,
  }) {
    return Venue(
      id: id ?? this.id,
      images: images ?? this.images,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      price: price ?? this.price,
      capacity: capacity ?? this.capacity,
    );
  }

  @override
  String toString() {
    return 'Venue(id: $id, images: $images, name: $name, description: $description, location: $location, price: $price, capacity: $capacity)';
  }
}
