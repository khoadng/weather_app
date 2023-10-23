import 'package:equatable/equatable.dart';

class WeatherData extends Equatable {
  const WeatherData({
    required this.temperature,
    required this.description,
    required this.icon,
  });

  final double temperature;
  final String description;
  final String icon;

  @override
  List<Object?> get props => [
        temperature,
        description,
        icon,
      ];
}
