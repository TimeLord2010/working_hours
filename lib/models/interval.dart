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
}
