import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/providers.dart';
import 'package:weather_app/widgets/app_search_bar.dart';

import '../widgets/floating_glassy_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          if (selectedLocation != null)
            ref.watch(currentWeatherProvider(selectedLocation!)).maybeWhen(
                  data: (data) =>
                      data != null && data.current.background.isNotEmpty
                          ? Positioned.fill(
                              child: ExtendedImage.network(
                                data.current.background,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const SizedBox.shrink(),
                  orElse: () => const SizedBox.shrink(),
                ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 64),
                AppSearchBar(
                  suggestionsBuilder: (query) => ref
                      .read(locationRepoProvider)
                      .suggestLocations(query: query),
                  onSelected: (value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 42),
                  child: selectedLocation != null
                      ? ref
                          .watch(currentWeatherProvider(selectedLocation!))
                          .when(
                            data: (data) => data != null
                                ? _buildWeather(data)
                                : const Text('No data'),
                            error: (error, stackTrace) => const Text(
                                'Something went wrong, could not fetch weather data'),
                            loading: () =>
                                const CircularProgressIndicator.adaptive(),
                          )
                      : const Text('No location selected'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeather(WeatherData data) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _buildWeatherCurrent(data),
          _buildWeatherDaily(data),
          const SizedBox(height: 8),
          _buildWeatherHourly(data),
        ],
      ),
    );
  }

  Widget _buildWeatherCurrent(WeatherData data) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${data.current.temperature.toInt()}°',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                  fontSize: 100,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            data.current.description,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherHourly(WeatherData data) {
    return FloatingGlassyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text('24-hour forecast'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            height: 200,
            child: ListView.builder(
              itemCount: data.hourly.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final weather = data.hourly[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        ExtendedImage.network(weather.icon),
                        Text(weather.description),
                        Text('${weather.temperature.ceil()}°C'),
                        const Spacer(),
                        Text(DateFormat('HH:mm').format(weather.time)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDaily(WeatherData data) {
    return FloatingGlassyCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text('7 days forecast'),
        ),
        for (final weather in data.daily)
          ListTile(
            leading: SizedBox(
              height: 32,
              width: 32,
              child: ExtendedImage.network(weather.icon),
            ),
            title: Text(weather.description),
            trailing: Text('${weather.temperatureMin}° / '
                '${weather.temperatureMax}°'),
          ),
      ],
    ));
  }
}
