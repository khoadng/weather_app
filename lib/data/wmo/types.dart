class WmoDescriptionData {
  final String dayDescription;
  final String dayImage;
  final String nightDescription;
  final String nightImage;

  WmoDescriptionData({
    required this.dayDescription,
    required this.dayImage,
    required this.nightDescription,
    required this.nightImage,
  });

  factory WmoDescriptionData.fromJson(Map<String, dynamic> json) {
    return WmoDescriptionData(
      dayDescription: json['day']['description'],
      dayImage: json['day']['image'],
      nightDescription: json['night']['description'],
      nightImage: json['night']['image'],
    );
  }
}
