import 'dart:convert';

import 'package:dio/dio.dart';

import 'types.dart';

const kRawGistGithubDataUrl =
    'https://gist.githubusercontent.com/stellasphere/9490c195ed2b53c707087c8c2db4ec0c/raw/76b0cb0ef0bfd8a2ec988aa54e30ecd1b483495d/descriptions.json';

const kWmoBackground = {
  '0': 'https://images.pexels.com/photos/896673/pexels-photo-896673.jpeg',
  '1': 'https://images.pexels.com/photos/896673/pexels-photo-896673.jpeg',
  '2': 'https://images.pexels.com/photos/896673/pexels-photo-896673.jpeg',
  '3': 'https://images.pexels.com/photos/3783385/pexels-photo-3783385.jpeg',
  '61': 'https://images.pexels.com/photos/2448749/pexels-photo-2448749.jpeg',
  '63': 'https://images.pexels.com/photos/2448749/pexels-photo-2448749.jpeg',
  '65': 'https://images.pexels.com/photos/2448749/pexels-photo-2448749.jpeg',
  '66': 'https://images.pexels.com/photos/2448749/pexels-photo-2448749.jpeg',
  '67': 'https://images.pexels.com/photos/2448749/pexels-photo-2448749.jpeg',
};

class WmoDataClient {
  WmoDataClient() {
    dio = Dio();
  }

  late final Dio dio;

  String? _cached;

  Future<Map<String, WmoDescriptionData>> getWmoData() async {
    if (_cached == null) {
      final response = await dio.get(
        kRawGistGithubDataUrl,
      );

      _cached ??= response.data as String;
    }

    final json = jsonDecode(_cached!);

    return {
      for (final entry in json.entries)
        entry.key: WmoDescriptionData.fromJson(entry.value).copyWith(
          background: kWmoBackground[entry.key],
        ),
    };
  }
}
