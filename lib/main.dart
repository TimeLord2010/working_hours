import 'package:flutter/material.dart';
import 'package:work_hours_tracking/ui/main_page/main_page.dart';

void main() {
  //debugRepaintRainbowEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const bc = 240;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color.fromARGB(255, bc, bc, bc),
      ),
      home: const MainPage(),
    );
  }
}
