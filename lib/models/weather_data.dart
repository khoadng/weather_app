import 'package:equatable/equatable.dart';
import 'package:weather_app/models/tempeture.dart';

class WeatherData extends Equatable {
  const WeatherData({
    required this.hourly,
    required this.daily,
    required this.current,
  });

  final List<HourlyWeatherData> hourly;
  final List<DailyWeatherData> daily;
  final CurrentWeatherData current;

  @override
  List<Object?> get props => [
        hourly,
        daily,
        current,
      ];
}

class HourlyWeatherData extends Equatable {
  const HourlyWeatherData({
    required this.temperature,
    required this.description,
    required this.icon,
    required this.time,
  });

  final Temperature temperature;
  final String description;
  final String icon;
  final DateTime time;

  @override
  List<Object?> get props => [
        temperature,
        description,
        icon,
        time,
      ];
}

class DailyWeatherData extends Equatable {
  const DailyWeatherData({
    required this.temperatureMax,
    required this.temperatureMin,
    required this.description,
    required this.icon,
    required this.date,
  });

  final Temperature temperatureMax;
  final Temperature temperatureMin;
  final String description;
  final String icon;
  final DateTime date;

  @override
  List<Object?> get props => [
        temperatureMax,
        temperatureMin,
        description,
        icon,
        date,
      ];
}

class CurrentWeatherData extends Equatable {
  const CurrentWeatherData({
    required this.temperature,
    required this.description,
    required this.icon,
    required this.background,
    required this.apparentTemperature,
    required this.pressureSeaLevel,
    required this.windSpeed,
    required this.windDirection,
    required this.precipitation,
    required this.humidity,
    required this.uvIndex,
    required this.sunrise,
    required this.sunset,
  });

  final Temperature temperature;
  final Temperature apparentTemperature;
  final double pressureSeaLevel;
  final double windSpeed;
  final int windDirection;
  final double precipitation;
  final int humidity;
  final double uvIndex;
  final DateTime sunrise;
  final DateTime sunset;

  final String description;
  final String icon;
  final String background;

  @override
  List<Object?> get props => [
        temperature,
        description,
        icon,
        background,
        apparentTemperature,
        pressureSeaLevel,
        windSpeed,
        windDirection,
        precipitation,
        humidity,
        uvIndex,
        sunrise,
        sunset,
      ];
}
