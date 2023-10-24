class WmoDescriptionData {
  final String dayDescription;
  final String dayImage;
  final String nightDescription;
  final String nightImage;
  final String backgroundDay;
  final String backgroundNight;

  WmoDescriptionData({
    required this.dayDescription,
    required this.dayImage,
    required this.nightDescription,
    required this.nightImage,
    required this.backgroundDay,
    required this.backgroundNight,
  });

  WmoDescriptionData copyWith({
    String? backgroundDay,
    String? backgroundNight,
  }) {
    return WmoDescriptionData(
      dayImage: dayImage,
      nightImage: nightImage,
      nightDescription: nightDescription,
      dayDescription: dayDescription,
      backgroundDay: backgroundDay ?? this.backgroundDay,
      backgroundNight: backgroundNight ?? this.backgroundNight,
    );
  }

  factory WmoDescriptionData.fromJson(Map<String, dynamic> json) {
    return WmoDescriptionData(
      dayDescription: json['day']['description'],
      dayImage: json['day']['image'],
      nightDescription: json['night']['description'],
      nightImage: json['night']['image'],
      backgroundDay: '',
      backgroundNight: '',
    );
  }
}
