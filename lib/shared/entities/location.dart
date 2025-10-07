class Location {
  final String area;
  final String city;
  final String state;
  final String country;
  final num pincode;

  const Location({
    this.area = "Barari",
    this.city = "Bhagalpur",
    this.state = "Bihar",
    this.country = "India",
    this.pincode = 812003,
  });

  factory Location.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('JSON cannot be null');
    }

    return Location(
      area: json['area'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',
      pincode: (json['pincode'] is int || json['pincode'] is double)
          ? json['pincode'] as num
          : num.tryParse(json['pincode']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
    };
  }

  Location copyWith({
    String? area,
    String? city,
    String? state,
    String? country,
    num? pincode,
  }) {
    return Location(
      area: area ?? this.area,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      pincode: pincode ?? this.pincode,
    );
  }

  @override
  String toString() {
    return 'Location(area: $area, city: $city, state: $state, country: $country, pincode: $pincode)';
  }
}
