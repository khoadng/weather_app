import 'package:weather_app/models/tempeture.dart';

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

  Future<WeatherData> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    final openMeteoWeatherData = await openMeteoClient.getWeather(
      latitude: latitude,
      longitude: longitude,
    );

    final wmoData = await wmoDataClient.getWmoData();

    return WeatherData(
      hourly: [
        for (var i = 0; i < openMeteoWeatherData.weatherCode.length; i++)
          HourlyWeatherData(
            temperature:
                Temperature.celsius(openMeteoWeatherData.temperature2m[i]),
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
            time: DateTime.tryParse(openMeteoWeatherData.time[i]) ??
                DateTime.now(),
          ),
      ],
      daily: [
        for (var i = 0;
            i < openMeteoWeatherData.temperature2mDailyMax.length;
            i++)
          DailyWeatherData(
            temperatureMax: Temperature.celsius(
                openMeteoWeatherData.temperature2mDailyMax[i]),
            temperatureMin: Temperature.celsius(
                openMeteoWeatherData.temperature2mDailyMin[i]),
            description: getWeatherDescription(
              openMeteoWeatherData.weatherCodeDaily[i].toString(),
              DateTime.tryParse(openMeteoWeatherData.timeDaily[i]) ??
                  DateTime.now(),
              wmoData,
            ),
            icon: getWeatherIconUrl(
              openMeteoWeatherData.weatherCodeDaily[i].toString(),
              DateTime.tryParse(openMeteoWeatherData.timeDaily[i]) ??
                  DateTime.now(),
              wmoData,
            ),
          ),
      ],
      current: CurrentWeatherData(
        temperature:
            Temperature.celsius(openMeteoWeatherData.temperature2mCurrent),
        description: getWeatherDescription(
          openMeteoWeatherData.weatherCodeCurrent.toString(),
          DateTime.tryParse(openMeteoWeatherData.timeCurrent) ?? DateTime.now(),
          wmoData,
        ),
        icon: getWeatherIconUrl(
          openMeteoWeatherData.weatherCodeCurrent.toString(),
          DateTime.tryParse(openMeteoWeatherData.timeCurrent) ?? DateTime.now(),
          wmoData,
        ),
        background: getWeatherBackground(
          openMeteoWeatherData.weatherCodeCurrent.toString(),
          DateTime.tryParse(openMeteoWeatherData.timeCurrent) ?? DateTime.now(),
          wmoData,
        ),
      ),
    );
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

String getWeatherBackground(
  String weatherCode,
  DateTime time,
  Map<String, WmoDescriptionData> wmoData,
) {
  final isNight = time.hour > 18 || time.hour < 6;

  return isNight
      ? wmoData[weatherCode]!.background
      : wmoData[weatherCode]!.background;
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
