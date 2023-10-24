class WmoDescriptionData {
  final String dayDescription;
  final String dayImage;
  final String nightDescription;
  final String nightImage;
  final String background;

  WmoDescriptionData({
    required this.dayDescription,
    required this.dayImage,
    required this.nightDescription,
    required this.nightImage,
    required this.background,
  });

  WmoDescriptionData copyWith({
    String? background,
  }) {
    return WmoDescriptionData(
      dayImage: dayImage,
      nightImage: nightImage,
      nightDescription: nightDescription,
      dayDescription: dayDescription,
      background: background ?? this.background,
    );
  }

  factory WmoDescriptionData.fromJson(Map<String, dynamic> json) {
    return WmoDescriptionData(
      dayDescription: json['day']['description'],
      dayImage: json['day']['image'],
      nightDescription: json['night']['description'],
      nightImage: json['night']['image'],
      background: '',
    );
  }
}
