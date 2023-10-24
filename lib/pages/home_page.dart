import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/tempeture.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/providers.dart';
import 'package:weather_app/widgets/app_search_bar.dart';
import 'package:weather_app/widgets/settings_modal.dart';

import '../widgets/floating_glassy_card.dart';
import '../widgets/weather_info_tile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String? selectedLocation;
  final searchController = SearchController();

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        searchController.text = selectedLocation ?? '';
      },
      child: Scaffold(
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
                                  enableLoadState: false,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const SizedBox.shrink(),
                    orElse: () => const SizedBox.shrink(),
                  ),
            RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(currentWeatherProvider(selectedLocation!));
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 64),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AppSearchBar(
                        controller: searchController,
                        suggestionsBuilder: (query) => ref
                            .read(locationRepoProvider)
                            .suggestLocations(query: query),
                        onSelected: (value) {
                          setState(
                            () {
                              selectedLocation = value;
                            },
                          );
                        },
                        onSettingsPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => const SettingsModal(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (selectedLocation != null)
                      SizedBox(
                        height: 24,
                        child: ref
                            .watch(currentWeatherProvider(selectedLocation!))
                            .maybeWhen(
                              skipLoadingOnRefresh: false,
                              loading: () => Text(
                                'Updating...',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              orElse: () => const SizedBox.shrink(),
                            ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeather(WeatherData data) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _buildWeatherCurrent(
            data,
            unit: ref.watch(currentTemperatureUnitProvider),
          ),
          _buildWeatherDaily(
            data,
            unit: ref.watch(currentTemperatureUnitProvider),
          ),
          const SizedBox(height: 8),
          _buildWeatherHourly(
            data,
            unit: ref.watch(currentTemperatureUnitProvider),
          ),
          const SizedBox(height: 8),
          _buildWeatherInfo(data),
          const SizedBox(height: 8),
          _buildDataSourceTile(),
        ],
      ),
    );
  }

  Widget _buildDataSourceTile() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Data provided in part by ',
              style: TextStyle(
                color: Theme.of(context).hintColor,
              ),
            ),
            TextSpan(
              text: 'Open-Meteo.com',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(WeatherData data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            FloatingGlassyCard(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                children: [
                  WeatherInfoTile(
                    title: 'Wind speed',
                    value: '${data.current.windSpeed} m/s',
                  ),
                  WeatherInfoTile(
                    title: 'Wind direction',
                    value: '${data.current.windDirection}°',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            FloatingGlassyCard(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                children: [
                  WeatherInfoTile(
                    title: 'Sunrise',
                    value: DateFormat('HH:mm').format(data.current.sunrise),
                  ),
                  WeatherInfoTile(
                    title: 'Sunset',
                    value: DateFormat('HH:mm').format(data.current.sunset),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FloatingGlassyCard(
            child: Column(
              children: [
                WeatherInfoTile(
                  title: 'Humidity',
                  value: '${data.current.humidity}%',
                ),
                WeatherInfoTile(
                  title: 'Real feel',
                  value: '${data.current.apparentTemperature.value.ceil()}°',
                ),
                WeatherInfoTile(
                  title: 'Precipitation',
                  value: '${data.current.precipitation.ceil()}%',
                ),
                WeatherInfoTile(
                  title: 'Pressure',
                  value: '${data.current.pressureSeaLevel} hPa',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherCurrent(
    WeatherData data, {
    TemperatureUnit unit = TemperatureUnit.celsius,
  }) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 1),
          Flexible(
            flex: 5,
            child: Column(
              children: [
                Text(
                  '${data.current.temperature.withUnit(unit).value.ceil()}°',
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
                const SizedBox(height: 8),
                Chip(
                  visualDensity: VisualDensity.compact,
                  label: Text('UV ${data.current.uvIndex}'),
                ),
              ],
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  Widget _buildWeatherHourly(
    WeatherData data, {
    TemperatureUnit unit = TemperatureUnit.celsius,
  }) {
    return FloatingGlassyCard(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardTitle(
            title: '24-hour forecast',
            icon: Icons.punch_clock,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            height: 200,
            child: ListView.builder(
              itemCount: data.hourly.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final weather = data.hourly[index];
                final temperature = weather.temperature.withUnit(unit);

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        ExtendedImage.network(weather.icon),
                        Text(weather.description),
                        Text(
                            '${temperature.value.ceil()}${temperature.unitString}'),
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

  Widget _buildWeatherDaily(
    WeatherData data, {
    TemperatureUnit unit = TemperatureUnit.celsius,
  }) {
    return FloatingGlassyCard(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CardTitle(
            title: '7-day forecast',
            icon: Icons.calendar_today,
          ),
          ...data.daily.map((e) {
            final weather = e;
            final temperatureMin = weather.temperatureMin.withUnit(unit);
            final temperatureMax = weather.temperatureMax.withUnit(unit);

            return ListTile(
              visualDensity: VisualDensity.compact,
              horizontalTitleGap: 4,
              leading: SizedBox(
                height: 32,
                width: 32,
                child: ExtendedImage.network(weather.icon),
              ),
              title: Row(
                children: [
                  Text(
                    DateFormat('dd/MM').format(weather.date),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                      child: Text(
                    weather.description,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  )),
                ],
              ),
              trailing: RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                    text: '${temperatureMin.value.ceil()}°',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  TextSpan(
                    text: ' / ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).hintColor.withOpacity(0.25),
                    ),
                  ),
                  TextSpan(
                    text: '${temperatureMax.value.ceil()}°',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              )),
            );
          }),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Theme.of(context).hintColor,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 18,
                  color: Theme.of(context).hintColor,
                ),
          ),
        ],
      ),
    );
  }
}
