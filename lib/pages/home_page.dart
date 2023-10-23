import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/providers.dart';
import 'package:weather_app/widgets/app_search_bar.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    ? ref.watch(currentWeatherProvider(selectedLocation!)).when(
                          data: (data) => data != null
                              ? _buildWeatherCard(data)
                              : const Text('No data'),
                          error: (error, stackTrace) =>
                              const Text('Something went wrong'),
                          loading: () =>
                              const CircularProgressIndicator.adaptive(),
                        )
                    : const Text('No location selected'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard(List<WeatherData> data) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final weather = data[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ExtendedImage.network(weather.icon),
                  Text(weather.description),
                  Text('${weather.temperature}°C'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
