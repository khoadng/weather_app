class OpenMeteoWeatherData {
  OpenMeteoWeatherData({
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.time,
    required this.temperature2m,
    required this.weatherCode,
    required this.temperature2mCurrent,
    required this.temperature2mDailyMin,
    required this.temperature2mDailyMax,
    required this.timeDaily,
    required this.weatherCodeDaily,
    required this.weatherCodeCurrent,
    required this.timeCurrent,
    required this.apparentTemperature,
    required this.pressureSeaLevel,
    required this.windSpeed10m,
    required this.windDirection10m,
    required this.precipitation,
    required this.humidity2m,
    required this.uvIndexMaxDaily,
    required this.sunriseDaily,
    required this.sunsetDaily,
  });

  final double latitude;
  final double longitude;
  final double elevation;
  final String timeCurrent;
  final List<String> time;
  final List<String> timeDaily;
  final List<double> temperature2m;
  final double temperature2mCurrent;
  final List<double> temperature2mDailyMin;
  final List<double> temperature2mDailyMax;
  final List<int> weatherCode;
  final List<int> weatherCodeDaily;
  final List<double> uvIndexMaxDaily;
  final List<String> sunriseDaily;
  final List<String> sunsetDaily;
  final int weatherCodeCurrent;
  final double apparentTemperature;
  final double pressureSeaLevel;
  final double windSpeed10m;
  final int windDirection10m;
  final double precipitation;
  final int humidity2m;

  factory OpenMeteoWeatherData.fromJson(Map<String, dynamic> json) {
    return OpenMeteoWeatherData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      elevation: json['elevation'],
      time: List<String>.from(json['hourly']['time']),
      temperature2m: List<double>.from(json['hourly']['temperature_2m']),
      weatherCode: List<int>.from(json['hourly']['weathercode']),
      temperature2mCurrent: json['current']['temperature_2m'],
      temperature2mDailyMin:
          List<double>.from(json['daily']['temperature_2m_min']),
      temperature2mDailyMax:
          List<double>.from(json['daily']['temperature_2m_max']),
      timeDaily: List<String>.from(json['daily']['time']),
      weatherCodeDaily: List<int>.from(json['daily']['weathercode']),
      weatherCodeCurrent: json['current']['weathercode'],
      timeCurrent: json['current']['time'],
      apparentTemperature: json['current']['apparent_temperature'],
      pressureSeaLevel: json['current']['pressure_msl'],
      windSpeed10m: json['current']['windspeed_10m'],
      windDirection10m: json['current']['winddirection_10m'],
      precipitation: json['current']['precipitation'],
      humidity2m: json['current']['relativehumidity_2m'],
      uvIndexMaxDaily: List<double>.from(json['daily']['uv_index_max']),
      sunriseDaily: List<String>.from(json['daily']['sunrise']),
      sunsetDaily: List<String>.from(json['daily']['sunset']),
    );
  }
}
