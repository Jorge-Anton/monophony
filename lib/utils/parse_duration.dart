Duration? parseDuration(String? duration) {
  if (duration == null) return null;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  List<String> parts = duration.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  seconds = int.parse(parts[parts.length - 1]);
  return Duration(hours: hours, minutes: minutes, seconds: seconds);
}