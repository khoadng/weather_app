import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_app/data/wmo/wmo_data_client.dart';
import 'package:weather_app/repositories/location/geocoding_data.dart';

import 'data/open_meteo/open_meteo_client.dart';
import 'repositories/location/location_repository.dart';
import 'repositories/weather_repository.dart';

void main() async {
  final openMeteoClient = OpenMeteoClient();
  final wmoDataClient = WmoDataClient();

  final weatherRepository = WeatherRepository(
    wmoDataClient: wmoDataClient,
    openMeteoClient: openMeteoClient,
  );

  final locationRepository = LocationRepository(
    geocodingData: geocodingData,
  );

  final places = await locationRepository.suggestLocations(query: 'B');

  print(places);

  // Pick a random place from the list
  final rnd = Random();
  final place = places[rnd.nextInt(places.length)];

  print(place);

  final location = await locationRepository.getLocation(place);

  if (location == null) {
    print('Location not found');
    return;
  }

  print(location);

  final weatherData = await weatherRepository.getWeather(
    latitude: location.lat,
    longitude: location.lon,
  );

  for (final data in weatherData) {
    print(data.temperature);
    print(data.description);
    print(data.icon);
    print('---');
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
