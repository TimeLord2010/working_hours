import 'package:flutter/material.dart';
import 'package:work_hours_tracking/db/intervals_repository.dart';
import 'package:work_hours_tracking/models/interval.dart' as im;
import 'package:work_hours_tracking/models/tag.dart';

class IntervalProvider with ChangeNotifier {
  final intervalHandler = IntervalsRepository();

  Future<int> put(im.Interval interval) async {
    final result = await intervalHandler.put(interval);
    notifyListeners();
    return result;
  }

  Future<Iterable<im.Interval>> find({
    DateTime? begin,
    DateTime? end,
    Iterable<int>? tags,
    int? limit,
    int? skip,
  }) {
    return intervalHandler.find(
      begin: begin,
      end: end,
      tags: tags,
      limit: limit,
      skip: skip,
    );
  }

  Map<Tag?, Duration> processTagSummary(Iterable<im.Interval> items) {
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
}
