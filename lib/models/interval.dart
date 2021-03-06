import 'package:isar/isar.dart';
import 'package:work_hours_tracking/models/tag.dart';

part 'interval.g.dart';

@Collection()
class Interval {
  int id = Isar.autoIncrement;
  @Index()
  late DateTime begin;
  late DateTime end;
  final tags = IsarLinks<Tag>();

  Duration get duration => end.difference(begin);

  @override
  bool operator ==(Object other) {
    return other is Interval && other.id == id;
  }

  @override
  int get hashCode => id;
}
