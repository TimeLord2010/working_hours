import 'package:work_hours_tracking/db/intervals_repository.dart';
import 'package:work_hours_tracking/repository/interval/put_interval_repository.dart';

PutIntervalRepository geratePutInterval() {
  final intervals = IntervalsRepository();
  return intervals;
}
