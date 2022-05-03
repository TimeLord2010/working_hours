import 'package:flutter/material.dart';
import 'package:work_hours_tracking/models/interval.dart' as im;
import 'package:work_hours_tracking/ui/history/history_record/edit_history_record/edit_history_record.dart';
import 'package:work_hours_tracking/ui/history/history_record/edit_history_record/edit_history_record_provider.dart';

class HistoryRecordProvider with ChangeNotifier {
  HistoryRecordProvider({
    required this.context,
    required this.interval,
    required this.onDelete,
  });

  final BuildContext context;
  final im.Interval interval;
  final void Function() onDelete;

  void onTap() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return EditHistoryRecord.create((c) => EditHistoryRecordProvider(
              context: c,
              interval: interval,
              onDelete: onDelete,
            ));
      },
    );
  }
}
