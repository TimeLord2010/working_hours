import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:work_hours_tracking/models/tag.dart' as tm;

class Tag extends StatelessWidget {
  const Tag({
    Key? key,
    required this.tag,
    this.onPressed,
    this.onDeleted,
  }) : super(key: key);

  final tm.Tag tag;
  final void Function()? onPressed;
  final void Function()? onDeleted;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      deleteIcon: Icon(
        MdiIcons.closeCircle,
        color: Colors.grey.shade300,
      ),
      label: Text(tag.name,
          style: const TextStyle(
            color: Colors.white,
          )),
      backgroundColor: Color(int.parse(tag.color)),
      onPressed: onPressed,
      onDeleted: onDeleted,
    );
  }
}
