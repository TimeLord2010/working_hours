import 'package:flutter/material.dart';
import 'package:work_hours_tracking/factories/delete_interval_factory.dart';
import 'package:work_hours_tracking/models/interval.dart' as im;
import 'package:work_hours_tracking/utils/date.dart';

class EditHistoryRecordProvider with ChangeNotifier {
  final TextEditingController beginController;
  final TextEditingController endController;
  // - - -
  final BuildContext context;
  final im.Interval interval;
  final void Function() onDelete;
  EditHistoryRecordProvider({
    required this.context,
    required this.interval,
    required this.onDelete,
  })  : beginController = TextEditingController(
          text: getNecessaryDateStr(interval.begin)!,
        ),
        endController = TextEditingController(
          text: getNecessaryDateStr(interval.end)!,
        );

  @override
  void dispose() {
    beginController.dispose();
    endController.dispose();
    super.dispose();
  }

  Future<void> delete() async {
    final deleteHandler = gerateDeleteInterval();
    await deleteHandler.delete(interval.id);
    onDelete();
    Navigator.pop(context);
  }
}
