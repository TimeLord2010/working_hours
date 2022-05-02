import 'package:work_hours_tracking/db/intervals_repository.dart';
import 'package:work_hours_tracking/repository/delete_interval_repository.dart';

DeleteIntervalRepository gerateDeleteInterval() {
  final intervalHandler = IntervalsRepository();
  return intervalHandler;
}
