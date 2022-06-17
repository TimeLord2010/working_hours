import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_hours_tracking/ui/components/tag.dart';
import 'package:work_hours_tracking/ui/components/tag_selection/tag_selection_provider.dart';

/// Adds tags and delete tags
///
class TagSelection extends StatelessWidget {
  const TagSelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => TagSelectionProvider(c),
      child: Consumer<TagSelectionProvider>(
        builder: (context, provider, child) {
          return Row(
            children: _getItems(provider),
          );
        },
      ),
    );
  }

  List<Widget> _getItems(TagSelectionProvider provider) {
    var tags = provider.tags;
    var add = provider.add;
    var items = tags.map((x) => Tag(tag: x));
    // TODO: Exception here
    return [
      Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: items.toList(),
        ),
      ),
      InputChip(
        label: const Text('+'),
        onPressed: add,
      ),
    ];
  }

  Padding _addPadding(Widget x) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: x,
    );
  }
}
