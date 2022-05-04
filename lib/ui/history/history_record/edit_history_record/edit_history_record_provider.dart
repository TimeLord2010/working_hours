import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_hours_tracking/models/interval.dart' as im;
import 'package:work_hours_tracking/ui/providers/interval_provider.dart';

class EditHistoryRecordProvider with ChangeNotifier {
  final TextEditingController beginController;
  final TextEditingController endController;
  // - - -
  final BuildContext context;
  final im.Interval interval;
  EditHistoryRecordProvider({
    required this.context,
    required this.interval,
  })  : beginController = TextEditingController(
          text: interval.begin.toIso8601String().split('.')[0],
        ),
        endController = TextEditingController(
          text: interval.end.toIso8601String().split('.')[0],
        );

  String? errorMessage;

  @override
  void dispose() {
    beginController.dispose();
    endController.dispose();
    super.dispose();
  }

  Future<void> delete() async {
    final intervalProvider = context.read<IntervalProvider>();
    await intervalProvider.delete(interval.id);
    Navigator.pop(context);
  }

  Future<void> save() async {
    errorMessage = null;
    final b = DateTime.tryParse(beginController.text);
    final e = DateTime.tryParse(endController.text);
    if (b == null) {
      errorMessage = 'Begin interval is not in a valid date format';
    }
    if (e == null) {
      errorMessage = 'End interval is not in a valid date format';
    }
    if (b!.isAfter(e!)) {
      errorMessage = 'Begin interval must be smaller than end interval';
    }
    final intervalHandler = context.read<IntervalProvider>();
    interval.begin = b;
    interval.end = e;
    intervalHandler.put(interval);
    Navigator.pop(context);
  }
}
