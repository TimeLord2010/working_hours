import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:work_hours_tracking/ui/pages/history/history_provider.dart';
import 'package:work_hours_tracking/ui/providers/interval_provider.dart';
import 'package:work_hours_tracking/utils/date.dart';

class DateTimeRangePicker extends StatelessWidget {
  const DateTimeRangePicker({
    Key? key,
    this.begin,
    this.end,
  }) : super(key: key);

  final DateTime? begin;
  final DateTime? end;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(getDateStr(begin) ?? ''),
        const Text(' - '),
        Text(getDateStr(end) ?? ''),
        const SizedBox(width: 5),
        TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(
                      value: context.read<HistoryProvider>(),
                    ),
                    ChangeNotifierProvider.value(
                      value: context.read<IntervalProvider>(),
                    ),
                  ],
                  child: Consumer<HistoryProvider>(
                    builder: (context, provider, child) {
                      return Scaffold(
                        body: SfDateRangePicker(
                          showTodayButton: true,
                          showActionButtons: true,
                          cancelText: 'Cancel',
                          confirmText: 'Filter',
                          onCancel: () {
                            Navigator.pop(context);
                          },
                          onSubmit: (result) {
                            if (result is PickerDateRange) {
                              context.read<HistoryProvider>().filterBegin = result.startDate;
                              context.read<HistoryProvider>().filterEnd = result.endDate;
                              context.read<IntervalProvider>().updateUI();
                            }
                            Navigator.pop(context);
                          },
                          selectionMode: DateRangePickerSelectionMode.range,
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
          child: const Text('Pick a range'),
        ),
      ],
    );
    // return Row(
    //   children: [
    //     Expanded(
    //       child: DateAndTimePicker(
    //         controller: beginController,
    //       ),
    //     ),
    //     const Text(
    //       ' - ',
    //       style: TextStyle(
    //         fontSize: 16,
    //       ),
    //     ),
    //     Expanded(
    //       child: DateAndTimePicker(
    //         controller: endController,
    //       ),
    //     ),
    //   ],
    // );
  }
}
