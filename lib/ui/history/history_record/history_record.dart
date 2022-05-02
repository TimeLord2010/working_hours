import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_hours_tracking/models/interval.dart' as im;
import 'package:work_hours_tracking/ui/history/history_record/history_record_provider.dart';
import 'package:work_hours_tracking/utils/date.dart';
import 'package:work_hours_tracking/utils/duration.dart';

class HistoryRecord extends StatelessWidget {
  const HistoryRecord({
    Key? key,
    required this.interval,
    required this.onDelete,
  }) : super(key: key);

  final im.Interval interval;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => HistoryRecordProvider(
        context: context,
        interval: interval,
        onDelete: onDelete,
      ),
      child: Consumer<HistoryRecordProvider>(
        builder: (context, provider, child) {
          return ListTile(
            title: Text(
              interval.duration.toReadableString(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: _getDateRange(),
            onTap: provider.onTap,
          );
        },
      ),
    );
  }

  Text _getDateRange() {
    return Text('${getNecessaryDateStr(interval.begin)} - ${getNecessaryDateStr(interval.end)}');
  }
}
