import '../../../shared/entities/location.dart';

class VenueDTO {
  final List<String> images;
  final String name;
  final String description;
  final Location location;
  final num price;
  final num capacity;

  VenueDTO({
    required this.images,
    required this.name,
    required this.description,
    required this.location,
    required this.price,
    required this.capacity,
  });
}
