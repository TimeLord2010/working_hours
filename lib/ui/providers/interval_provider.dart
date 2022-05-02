import 'package:flutter/material.dart';
import 'package:work_hours_tracking/db/intervals_repository.dart';
import 'package:work_hours_tracking/models/interval.dart' as im;

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
}
