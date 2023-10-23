class OpenMeteoWeatherData {
  OpenMeteoWeatherData({
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.time,
    required this.temperature2m,
    required this.weatherCode,
  });

  final double latitude;
  final double longitude;
  final double elevation;
  final List<String> time;
  final List<double> temperature2m;
  final List<int> weatherCode;

  factory OpenMeteoWeatherData.fromJson(Map<String, dynamic> json) {
    return OpenMeteoWeatherData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      elevation: json['elevation'],
      time: List<String>.from(json['hourly']['time']),
      temperature2m: List<double>.from(json['hourly']['temperature_2m']),
      weatherCode: List<int>.from(json['hourly']['weathercode']),
    );
  }
}
