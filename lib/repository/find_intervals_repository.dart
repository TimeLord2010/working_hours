import 'package:work_hours_tracking/models/interval.dart';

abstract class FindIntervalsRepository {
  Future<Iterable<Interval>> find({
    DateTime? begin,
    DateTime? end,
    Iterable<int>? tags,
    int? limit,
    int? skip,
  });
}
