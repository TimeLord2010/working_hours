import 'package:flutter/material.dart';
import 'package:work_hours_tracking/models/tag.dart';
import 'package:work_hours_tracking/ui/dialogs/tag_selector.dart';

class TagSelectionProvider with ChangeNotifier {
  final BuildContext context;

  TagSelectionProvider(this.context);

  List<Tag> tags = [
    Tag()
      ..name = 'Test'
      ..color = "0xAAFFAA",
  ];

  void add() async {
    await showDialog(
      context: context,
      builder: (context) {
        var dialog = const AlertDialog(
          content: TagSelector(),
        );
        return dialog;
      },
    );
    notifyListeners();
  }
}
