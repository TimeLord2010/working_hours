enum DateFormat { iso, ddMMyyyy }

String getTimeStr({
  DateTime? date,
  Duration? duration,
  bool showHour = true,
  bool showSecond = false,
}) {
  if (date == null && duration == null) {
    throw Exception('Date or duration must be given to gettimeStr().');
  }
  final h = date == null ? duration!.inHours - (duration.inDays * 24) : date.hour;
  final m = date == null ? duration!.inMinutes - (h * 60) : date.minute;
  final s = date == null ? duration!.inSeconds - (m * 60) : date.second;
  var hour = h.toString().padLeft(2, '0');
  var minute = m.toString().padLeft(2, '0');
  final second = s.toString().padLeft(2, '0');
  if (showHour && showSecond) {
    return '$hour:$minute:$second';
  } else if (showHour && !showSecond) {
    return '$hour:$minute';
  } else if (!showHour && showSecond) {
    return '$minute:$second';
  }
  return "invalid condition";
}

String? getDateStr(
  DateTime? dt, {
  bool year = true,
  bool month = true,
  bool day = true,
  DateFormat format = DateFormat.iso,
}) {
  if (dt == null) return null;
  var list = [];
  if (year) list.add(dt.year.toString().padLeft(2, '0'));
  if (month) list.add(dt.month.toString().padLeft(2, '0'));
  if (day) list.add(dt.day.toString().padLeft(2, '0'));
  if (format == DateFormat.iso) {
    return list.join('-');
  } else if (format == DateFormat.ddMMyyyy) {
    return list.reversed.join('/');
  }
  throw Exception('Invalid date format.');
}

String? getNecessaryDateStr(
  DateTime? dt, {
  DateFormat format = DateFormat.iso,
}) {
  if (dt == null) return null;
  var now = DateTime.now();
  if (now.year != dt.year) {
    return getDateStr(dt, format: format);
  } else if (now.month != dt.month) {
    return getDateStr(dt, year: false, format: format);
  } else if (now.day != dt.day) {
    return getDateStr(dt, year: false, month: true, format: format);
  } else {
    return getTimeStr(date: dt);
  }
}
