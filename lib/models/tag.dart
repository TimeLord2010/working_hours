import 'package:isar/isar.dart';
import 'package:work_hours_tracking/models/interval.dart';

part 'tag.g.dart';

@Collection()
class Tag {
  int id = Isar.autoIncrement;

  @Index()
  late String tag;

  late String color;
}

Map<Tag?, Duration> processTagSummary(Iterable<Interval> items) {
  Map<Tag?, Duration> result = {};
  for (final item in items) {
    final duration = item.end.difference(item.begin);
    for (final tag in item.tags) {
      result[tag] = duration + (result[tag] ?? const Duration());
    }
    if (item.tags.isEmpty) {
      result[null] = duration + (result[null] ?? const Duration());
    }
  }
  return result;
}
