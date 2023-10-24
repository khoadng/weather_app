import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/data/wmo/wmo_data_client.dart';
import 'package:weather_app/repositories/location/geocoding_data.dart';

import 'data/open_meteo/open_meteo_client.dart';
import 'models/weather_data.dart';
import 'repositories/location/location_repository.dart';
import 'repositories/weather_repository.dart';

final weatherRepoProvider = Provider<WeatherRepository>((ref) {
  final openMeteoClient = ref.watch(openMeteoClientProvider);
  final wmoClient = ref.watch(wmoClientProvider);
  return WeatherRepository(
    openMeteoClient: openMeteoClient,
    wmoDataClient: wmoClient,
  );
});

final locationRepoProvider = Provider<LocationRepository>((ref) {
  final geocodingData = ref.watch(geocodingDataProvider);
  return LocationRepository(
    geocodingData: geocodingData,
  );
});

final geocodingDataProvider =
    Provider<Map<String, Map<String, dynamic>>>((ref) {
  return geocodingData;
});

final openMeteoClientProvider = Provider<OpenMeteoClient>((ref) {
  return OpenMeteoClient();
});

final wmoClientProvider = Provider<WmoDataClient>((ref) {
  return WmoDataClient();
});

final currentWeatherProvider =
    FutureProvider.autoDispose.family<WeatherData?, String>((ref, place) async {
  final weatherRepo = ref.watch(weatherRepoProvider);
  final locationRepo = ref.watch(locationRepoProvider);
  final location = await locationRepo.getLocation(place);
  if (location == null) return null;
  final weathers = await weatherRepo.getWeather(
    latitude: location.lat,
    longitude: location.lon,
  );
  return weathers;
});
