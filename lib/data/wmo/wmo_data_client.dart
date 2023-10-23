import 'dart:convert';

import 'package:dio/dio.dart';

import 'types.dart';

const kRawGistGithubDataUrl =
    'https://gist.githubusercontent.com/stellasphere/9490c195ed2b53c707087c8c2db4ec0c/raw/76b0cb0ef0bfd8a2ec988aa54e30ecd1b483495d/descriptions.json';

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
        entry.key: WmoDescriptionData.fromJson(entry.value),
    };
  }
}
