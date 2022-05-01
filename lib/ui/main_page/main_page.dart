import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_hours_tracking/ui/history/history.dart';
import 'package:work_hours_tracking/ui/providers/interval_provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (c) => MainPageProvider()),
        ChangeNotifierProvider(create: (c) => IntervalProvider()),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Working Hours'),
            bottom: const TabBar(
              tabs: [
                Tab(child: Text('History')),
                Tab(child: Text('Report')),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              History(),
              Text('Report'),
            ],
          ),
        ),
      ),
    );
  }
}
