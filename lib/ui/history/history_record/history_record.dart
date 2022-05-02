import 'package:flutter/material.dart';
import 'package:work_hours_tracking/models/interval.dart' as im;
import 'package:work_hours_tracking/utils/date.dart';
import 'package:work_hours_tracking/utils/duration.dart';

class HistoryRecord extends StatelessWidget {
  const HistoryRecord({
    Key? key,
    required this.interval,
  }) : super(key: key);

  final im.Interval interval;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        interval.duration.toReadableString(),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text('${getNecessaryDateStr(interval.begin)} - ${getNecessaryDateStr(interval.end)}'),
    );
  }
}
