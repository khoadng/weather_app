import 'package:flutter/material.dart';

class WeatherInfoTile extends StatelessWidget {
  const WeatherInfoTile({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      minLeadingWidth: 0,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).hintColor,
        ),
      ),
      trailing: Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
