import 'package:equatable/equatable.dart';

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

  final double temperature;
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
  });

  final double temperatureMax;
  final double temperatureMin;
  final String description;
  final String icon;

  @override
  List<Object?> get props => [
        temperatureMax,
        temperatureMin,
        description,
        icon,
      ];
}

class CurrentWeatherData extends Equatable {
  const CurrentWeatherData({
    required this.temperature,
    required this.description,
    required this.icon,
    required this.background,
  });

  final double temperature;
  final String description;
  final String icon;
  final String background;

  @override
  List<Object?> get props => [
        temperature,
        description,
        icon,
        background,
      ];
}
