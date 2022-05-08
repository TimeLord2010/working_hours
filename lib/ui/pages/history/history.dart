import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_hours_tracking/models/interval.dart' as im;
import 'package:work_hours_tracking/models/tag.dart' as tm;
import 'package:work_hours_tracking/ui/components/date_time_range_picker.dart';
import 'package:work_hours_tracking/ui/components/tag_selection.dart';
import 'package:work_hours_tracking/ui/pages/history/history_provider.dart';
import 'package:work_hours_tracking/ui/pages/history/history_record/history_record.dart';
import 'package:work_hours_tracking/ui/providers/interval_provider.dart';
import 'package:work_hours_tracking/utils/duration.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => HistoryProvider(c),
      child: _getContent(),
    );
  }

  Column _getContent() {
    return Column(
      children: [
        _getStopWatchPanel(),
        const Divider(),
        _getHistorySearchPanel(),
        const Divider(),
        _getTagSummaryPanel(),
      ],
    );
  }

  SizedBox _getTagSummaryPanel() {
    return SizedBox(
      height: 80,
      child: Consumer<IntervalProvider>(
        builder: (context, value, child) {
          return FutureBuilder<Iterable<im.Interval>>(
            future: value.find(),
            builder: (context, snap) {
              if (snap.hasData) {
                final Iterable<im.Interval> data = snap.data!;
                return _getTagSummaryContent(data);
              } else if (snap.hasError) {
                return Text(snap.error.toString());
              } else {
                return const CircularProgressIndicator.adaptive();
              }
            },
          );
        },
      ),
    );
  }

  Widget _getTagSummaryContent(Iterable<im.Interval> data) {
    final processed = tm.processTagSummary(data);
    List<Widget> items = [];
    for (final item in processed.entries) {
      final tagName = item.key?.tag ?? 'Total';
      items.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            tagName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Text(item.value.toReadableString()),
        ],
      ));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: items,
      ),
    );
  }

  Widget _getHistorySearchPanel() {
    return Expanded(
      child: Column(
        children: [
          Selector<HistoryProvider, List<DateTime?>>(
            selector: (context, value) => [value.filterBegin, value.filterEnd],
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    const Text('Interval: '),
                    DateTimeRangePicker(
                      begin: value[0],
                      end: value[1],
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<IntervalProvider>(
              builder: (context, provider, child) {
                final historyProvider = Provider.of<HistoryProvider>(context, listen: false);
                return FutureBuilder<Iterable<im.Interval>>(
                  future: provider.find(
                    begin: historyProvider.filterBegin,
                    end: historyProvider.filterEnd,
                  ),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      final data = snap.data!;
                      return _getHistorySearchContent(provider, data);
                    } else if (snap.hasError) {
                      return Text(snap.error.toString());
                    } else {
                      return const CircularProgressIndicator.adaptive();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getHistorySearchContent(IntervalProvider provider, Iterable<im.Interval> data) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey.shade300,
          indent: 15,
          endIndent: 15,
        );
      },
      itemBuilder: (context, index) {
        final item = data.elementAt(index);
        return HistoryRecord(
          interval: item,
        );
      },
      itemCount: data.length,
    );
  }

  Widget _getStopWatchPanel() {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 12,
        ),
        child: LayoutBuilder(
          builder: ((context, constraints) {
            return _getStopWatch(constraints.maxHeight);
          }),
        ),
      ),
    );
  }

  Widget _getStopWatch(double height) {
    return Row(
      children: [
        Selector<HistoryProvider, bool>(
          selector: (context, value) => value.isRunning,
          builder: (context, value, child) {
            return ElevatedButton(
              onPressed: Provider.of<HistoryProvider>(context).onStopWatchTap,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(_getStopWatchIcon(value), size: 40),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
              ),
            );
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Selector<HistoryProvider, String>(
              selector: (context, value) => value.display,
              shouldRebuild: (old, item) {
                return old != item;
              },
              builder: (context, value, child) {
                return Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                );
              },
            ),
            const TagSelection(),
          ],
        ),
        const Spacer(),
      ],
    );
  }

  IconData _getStopWatchIcon(bool isRunning) {
    return isRunning ? Icons.stop : Icons.play_arrow;
  }
}
