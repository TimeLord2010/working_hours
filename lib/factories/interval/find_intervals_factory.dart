import 'package:work_hours_tracking/db/intervals_repository.dart';
import 'package:work_hours_tracking/repository/interval/find_intervals_repository.dart';

FindIntervalsRepository gerateFindIntervals() {
  final intervals = IntervalsRepository();
  return intervals;
}
