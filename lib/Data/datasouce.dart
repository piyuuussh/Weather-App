class City {
  final String city;
  final String country;
  final double lat;
  final double lng;

  City({
    required this.city,
    required this.country,
    required this.lat,
    required this.lng,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      city: json['city'] ?? 'Unknown',
      country: json['country'] ?? 'Unknown',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
