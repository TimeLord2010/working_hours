import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:work_hours_tracking/models/interval.dart' as im;
import 'package:work_hours_tracking/ui/providers/interval_provider.dart';

class HistoryProvider with ChangeNotifier {
  final BuildContext context;

  HistoryProvider(this.context);

  final _stopWatchTimer = StopWatchTimer();

  StreamSubscription<int>? tickSubscription;

  int ticks = 0;
  DateTime? begin;

  @override
  void dispose() async {
    super.dispose();
    tickSubscription?.cancel();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  bool get isRunning => _stopWatchTimer.isRunning;

  String get display {
    int hours = StopWatchTimer.getRawHours(ticks);
    return StopWatchTimer.getDisplayTime(
      ticks,
      hours: hours != 0,
      milliSecond: false,
    );
  }

  void onStopWatchTap() {
    if (_stopWatchTimer.isRunning) {
      stop();
    } else {
      begin = DateTime.now();
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
      tickSubscription = _stopWatchTimer.rawTime.listen(null);
      tickSubscription!.onData((data) {
        ticks = data;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  void stop() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    notifyListeners();
  }

  void reset() async {
    final interval = im.Interval()
      ..begin = begin!
      ..end = DateTime.now();
    await context.read<IntervalProvider>().put(interval);
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    tickSubscription?.cancel();
    tickSubscription = null;
    ticks = 0;
    notifyListeners();
  }
}
