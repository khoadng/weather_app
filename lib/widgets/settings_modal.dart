import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/providers.dart';

import '../models/tempeture.dart';

class SettingsModal extends ConsumerWidget {
  const SettingsModal({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Temperature Unit'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(ref.watch(currentTemperatureUnitProvider).name,
                    style: TextStyle(color: Theme.of(context).hintColor)),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => OptionActionSheet(
                  onChanged: (value) {
                    ref.read(currentTemperatureUnitProvider.notifier).state =
                        value;
                    Navigator.of(context).pop();
                  },
                  optionName: (option) => option.name,
                  options: TemperatureUnit.values,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class OptionActionSheet<T> extends StatelessWidget {
  const OptionActionSheet({
    super.key,
    required this.onChanged,
    required this.options,
    required this.optionName,
  });

  final void Function(T option) onChanged;
  final List<T> options;
  final String Function(T option) optionName;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: options
            .map((e) => ListTile(
                  title: Text(optionName(e)),
                  onTap: () {
                    Navigator.pop(context);
                    onChanged(e);
                  },
                ))
            .toList(),
      ),
    );
  }
}
