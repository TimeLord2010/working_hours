import 'package:work_hours_tracking/models/interval.dart';

abstract class PutIntervalRepository {
  Future<int> put(Interval interval);
}
