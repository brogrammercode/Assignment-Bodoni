import '../../venue/data/model.dart';

class WeedingDTO {
  final DateTime td;
  final Venue venue;
  final bool photography;
  final bool catering;
  final bool mehendi;
  final bool sangeet;
  final bool honeymoon;

  WeedingDTO({
    required this.td,
    required this.venue,
    required this.photography,
    required this.catering,
    required this.mehendi,
    required this.sangeet,
    required this.honeymoon,
  });
}
