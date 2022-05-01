import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:work_hours_tracking/ui/history/history_provider.dart';
import 'package:work_hours_tracking/models/interval.dart' as im;
import 'package:work_hours_tracking/ui/providers/interval_provider.dart';
import 'package:work_hours_tracking/utils/date.dart';
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
      ],
    );
  }

  Widget _getHistorySearchPanel() {
    return Consumer<IntervalProvider>(
      builder: (context, provider, child) {
        return Expanded(
          child: FutureBuilder<Iterable<im.Interval>>(
            future: provider.find(),
            builder: (context, snap) {
              if (snap.hasData) {
                final data = snap.data!;
                return _getHistorySearchContent(data);
              } else if (snap.hasError) {
                return Text(snap.error.toString());
              } else {
                return const CircularProgressIndicator.adaptive();
              }
            },
          ),
        );
      },
    );
  }

  ListView _getHistorySearchContent(Iterable<im.Interval> data) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = data.elementAt(index);
        final duration = item.end.difference(item.begin);
        return ListTile(
          title: Text(
            duration.toReadableString(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          subtitle: Text('${getNecessaryDateStr(item.begin)} - ${getNecessaryDateStr(item.end)}'),
        );
      },
      itemCount: data.length,
    );
  }

  Widget _getStopWatchPanel() {
    return Consumer<HistoryProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 12,
            ),
            child: LayoutBuilder(
              builder: ((context, constraints) {
                return _getStopWatch(provider, constraints.maxHeight);
              }),
            ),
          ),
        );
      },
    );
  }

  Row _getStopWatch(HistoryProvider provider, double height) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: provider.onStopWatchTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(_getStopWatchIcon(provider), size: 40),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const CircleBorder()),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              provider.display,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              children: [
                InputChip(
                  deleteIcon: Icon(
                    MdiIcons.closeCircle,
                    color: Colors.grey.shade300,
                  ),
                  onDeleted: () {},
                  label: const Text('G4Flex',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  onPressed: () {
                    print('I am the one thing in life.');
                  },
                  backgroundColor: Colors.green,
                ),
                InputChip(
                  label: const Text('+'),
                  onPressed: () {},
                ),
              ]
                  .map((x) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: x,
                      ))
                  .toList(),
            ),
          ],
        ),
        if (provider.ticks != 0) ...[
          const Spacer(),
          Align(
            alignment: Alignment.topCenter,
            child: TextButton(
              onPressed: provider.reset,
              child: const Text('Stop'),
            ),
          ),
        ],
      ],
    );
  }

  IconData _getStopWatchIcon(HistoryProvider provider) {
    return provider.isRunning ? Icons.pause : Icons.play_arrow;
  }
}
