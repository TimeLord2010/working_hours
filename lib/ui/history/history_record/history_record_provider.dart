import 'package:flutter/material.dart';
import 'package:work_hours_tracking/factories/delete_interval_factory.dart';
import 'package:work_hours_tracking/models/interval.dart' as im;
import 'package:work_hours_tracking/utils/date.dart';
import 'package:work_hours_tracking/utils/duration.dart';
import 'package:work_hours_tracking/ui/components/wh_text_field.dart';

class HistoryRecordProvider with ChangeNotifier {
  HistoryRecordProvider({
    required this.context,
    required this.interval,
    required this.onDelete,
  });

  final BuildContext context;
  final im.Interval interval;
  final void Function() onDelete;

  final _beginController = TextEditingController();
  final _endController = TextEditingController();

  @override
  void dispose() {
    _beginController.dispose();
    _endController.dispose();
    super.dispose();
  }

  void onTap() async {
    _beginController.text = getNecessaryDateStr(interval.begin)!;
    _endController.text = getNecessaryDateStr(interval.end)!;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(8),
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                interval.duration.toReadableString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: WHTextField(
                      controller: _beginController,
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.calendar_month),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  const Text(
                    ' - ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: WHTextField(
                      controller: _endController,
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.calendar_month),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  InputChip(
                    label: const Text('+'),
                    onPressed: () {},
                  ),
                ],
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _delete() async {
    final deleteHandler = gerateDeleteInterval();
    await deleteHandler.delete(interval.id);
    onDelete();
  }
}
