import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_hours_tracking/ui/components/wh_text_field.dart';
import 'package:work_hours_tracking/ui/history/history_record/edit_history_record/edit_history_record_provider.dart';
import 'package:work_hours_tracking/utils/duration.dart';

class EditHistoryRecord extends StatelessWidget {
  const EditHistoryRecord._({
    Key? key,
  }) : super(key: key);

  static Widget create(EditHistoryRecordProvider Function(BuildContext) create) {
    return ChangeNotifierProvider<EditHistoryRecordProvider>(
      create: create,
      child: const EditHistoryRecord._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EditHistoryRecordProvider>();
    final interval = provider.interval;
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
                  controller: provider.beginController,
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
                  controller: provider.endController,
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
              onPressed: provider.delete,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
