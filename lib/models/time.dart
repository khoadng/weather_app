extension DateTimeX on DateTime {
  bool isNight() {
    final hour = this.hour;
    return hour < 6 || hour > 18;
  }
}
