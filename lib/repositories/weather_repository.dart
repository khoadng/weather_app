import '../data/open_meteo/open_meteo_client.dart';
import '../data/wmo/types.dart';
import '../data/wmo/wmo_data_client.dart';
import '../models/weather_data.dart';

class WeatherRepository {
  WeatherRepository({
    required this.wmoDataClient,
    required this.openMeteoClient,
  });

  final WmoDataClient wmoDataClient;
  final OpenMeteoClient openMeteoClient;

  Future<List<WeatherData>> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    final openMeteoWeatherData = await openMeteoClient.getWeather(
      latitude: latitude,
      longitude: longitude,
    );

    final wmoData = await wmoDataClient.getWmoData();

    return [
      for (var i = 0; i < openMeteoWeatherData.weatherCode.length; i++)
        WeatherData(
          temperature: openMeteoWeatherData.temperature2m[i],
          description: getWeatherDescription(
            openMeteoWeatherData.weatherCode[i].toString(),
            DateTime.tryParse(openMeteoWeatherData.time[i]) ?? DateTime.now(),
            wmoData,
          ),
          icon: getWeatherIconUrl(
            openMeteoWeatherData.weatherCode[i].toString(),
            DateTime.tryParse(openMeteoWeatherData.time[i]) ?? DateTime.now(),
            wmoData,
          ),
        ),
    ];
  }
}

String getWeatherIconUrl(
  String weatherCode,
  DateTime time,
  Map<String, WmoDescriptionData> wmoData,
) {
  final isNight = time.hour > 18 || time.hour < 6;

  return isNight
      ? wmoData[weatherCode]!.nightImage
      : wmoData[weatherCode]!.dayImage;
}

String getWeatherDescription(
  String weatherCode,
  DateTime time,
  Map<String, WmoDescriptionData> wmoData,
) {
  final isNight = time.hour > 18 || time.hour < 6;

  return isNight
      ? wmoData[weatherCode]!.nightDescription
      : wmoData[weatherCode]!.dayDescription;
}
