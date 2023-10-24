import 'package:equatable/equatable.dart';

enum TemperatureUnit {
  celsius,
  fahrenheit,
}

class Temperature extends Equatable {
  const Temperature({
    required this.value,
    required this.unit,
  });

  factory Temperature.celsius(double? value) => Temperature(
        value: value ?? 0,
        unit: TemperatureUnit.celsius,
      );

  factory Temperature.fahrenheit(double? value) => Temperature(
        value: value ?? 0,
        unit: TemperatureUnit.fahrenheit,
      );

  final double value;
  final TemperatureUnit unit;

  @override
  List<Object?> get props => [
        value,
        unit,
      ];
}

extension TemperatureX on Temperature {
  String get unitString => switch (unit) {
        TemperatureUnit.celsius => '°C',
        TemperatureUnit.fahrenheit => '°F'
      };

  Temperature withUnit(TemperatureUnit unit) => switch (unit) {
        TemperatureUnit.celsius => toCelsius(),
        TemperatureUnit.fahrenheit => toFahrenheit(),
      };
}

extension TemperatureConversion on Temperature {
  Temperature toCelsius() {
    if (unit == TemperatureUnit.celsius) return this;
    return Temperature.celsius((value - 32) * 5 / 9);
  }

  Temperature toFahrenheit() {
    if (unit == TemperatureUnit.fahrenheit) return this;
    return Temperature.fahrenheit((value * 9 / 5) + 32);
  }
}
