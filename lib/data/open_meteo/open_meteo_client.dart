import 'package:dio/dio.dart';

import 'types.dart';

const kOpenMeteoUrl = 'https://api.open-meteo.com/v1';

class OpenMeteoClient {
  OpenMeteoClient() {
    dio = Dio(BaseOptions(baseUrl: kOpenMeteoUrl));
  }

  late final Dio dio;

  Future<OpenMeteoWeatherData> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    final response = await dio.get(
      '/forecast',
      queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'hourly': 'temperature_2m,weathercode',
        'daily': 'temperature_2m_max,temperature_2m_min,weathercode',
        'current': 'temperature_2m,weathercode',
        'timezone': 'auto',
      },
    );

    return OpenMeteoWeatherData.fromJson(response.data);
  }
}
