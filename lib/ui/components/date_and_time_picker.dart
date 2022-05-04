import 'package:flutter/material.dart';
import 'package:work_hours_tracking/ui/components/wh_text_field.dart';

class DateAndTimePicker extends StatelessWidget {
  const DateAndTimePicker({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return WHTextField(
      controller: controller,
      textStyle: const TextStyle(
        fontSize: 16,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.calendar_month),
        onPressed: () {},
      ),
    );
  }
}
