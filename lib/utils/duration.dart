import 'package:work_hours_tracking/utils/time.dart';

extension StringUtils on Duration {
  String toReadableString() {
    int seconds = inSeconds;
    int days = seconds ~/ secondsPerDay;
    seconds -= days * secondsPerDay;
    int hours = seconds ~/ secondsPerHour;
    seconds -= hours * secondsPerHour;
    int minutes = seconds ~/ 60;
    seconds -= minutes * 60;
    // int days = hoursToDays(minutesToHours(secondsToMinutes(seconds)));
    // int hours = minutesToHours(secondsToMinutes(seconds)) - (days * 24);
    // int minutes = secondsToMinutes(seconds) - ((hours + (days * 24)) * 60);
    // seconds = seconds - ((minutes + ((hours + (days * 24)) * 60)) * 60);
    final dayStr = days.toString().padLeft(2, '0') + 'd';
    final hourStr = hours.toString().padLeft(2, '0') + 'h';
    final minutesStr = minutes.toString().padLeft(2, '0') + 'min';
    final secondsStr = seconds.toString().padLeft(2, '0') + 's';
    if (days > 0) {
      return '$dayStr $hourStr $minutesStr $secondsStr';
    } else if (hours > 0) {
      return '$hourStr $minutesStr $secondsStr';
    } else if (minutes > 0) {
      return '$minutesStr $secondsStr';
    } else {
      return secondsStr;
    }
  }
}
