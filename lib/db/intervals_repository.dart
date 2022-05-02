import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:work_hours_tracking/models/interval.dart';
import 'package:work_hours_tracking/models/tag.dart';
import 'package:work_hours_tracking/repository/delete_interval_repository.dart';
import 'package:work_hours_tracking/repository/find_intervals_repository.dart';
import 'package:work_hours_tracking/repository/put_interval_repository.dart';

class IntervalsRepository with FindIntervalsRepository, PutIntervalRepository, DeleteIntervalRepository {
  Future<Isar> get _rep async {
    final dir = await getApplicationSupportDirectory();
    final isar = await Isar.open(
      schemas: [
        IntervalSchema,
        TagSchema,
      ],
      directory: dir.path,
    );
    return isar;
  }

  Future<bool> _close(Isar isar) {
    return isar.close();
  }

  @override
  Future<Iterable<Interval>> find({
    DateTime? begin,
    DateTime? end,
    Iterable<int>? tags,
    int? limit,
    int? skip,
  }) async {
    int _limit = limit ?? 50;
    int _skip = skip ?? 0;
    final rep = await _rep;
    try {
      final intervals = rep.intervals;
      final where = intervals.where();
      QueryBuilder<Interval, Interval, QFilterCondition> query;
      if (begin != null) {
        query = where.beginGreaterThan(begin).filter();
      } else {
        query = intervals.filter();
      }
      QueryBuilder<Interval, Interval, QAfterFilterCondition>? condition;
      if (end != null) {
        condition = (condition ?? query).endLessThan(end);
      }
      if (tags != null && tags.isNotEmpty) {
        condition = (condition ?? query).tags((q) {
          for (int i = 0; i < tags.length - 1; i++) {
            q = q.idEqualTo(tags.elementAt(i)).or();
          }
          return q.idEqualTo(tags.last);
        });
      }
      condition ??= query.endLessThan(DateTime.now());
      return await condition.sortByBeginDesc().offset(_skip).limit(_limit).findAll();
    } finally {
      await _close(rep);
    }
  }

  @override
  Future<int> put(Interval interval) async {
    final rep = await _rep;
    try {
      int? id;
      await rep.writeTxn((rep) async {
        id = await rep.intervals.put(interval);
      });
      return id!;
    } finally {
      await _close(rep);
    }
  }

  @override
  Future<void> delete(int id) async {
    final rep = await _rep;
    try {
      await rep.intervals.delete(id);
    } finally {
      await _close(rep);
    }
  }
}
