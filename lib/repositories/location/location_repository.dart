typedef Location = ({
  double lat,
  double lon,
});

class LocationRepository {
  LocationRepository({
    required this.geocodingData,
  });
  final Map<String, dynamic> geocodingData;

  Future<List<String>> suggestLocations({
    required String query,
    int limit = 10,
  }) async {
    final suggestions = <String>[];

    for (final key in geocodingData.keys) {
      if (suggestions.length >= limit) break;

      if (key.toLowerCase().contains(query.toLowerCase())) {
        suggestions.add(key);
      }
    }

    return suggestions;
  }

  Future<Location?> getLocation(String cityName) async {
    final data = geocodingData[cityName];

    if (data == null) return null;

    final lat = data['latitude'] as double?;
    final lon = data['longitude'] as double?;

    if (lat == null || lon == null) return null;

    return (
      lat: lat,
      lon: lon,
    );
  }
}
