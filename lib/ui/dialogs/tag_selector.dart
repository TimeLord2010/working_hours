import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_hours_tracking/models/tag.dart' as tm;
import 'package:work_hours_tracking/ui/dialogs/tag_selector_provider.dart';

/// Select and create tags.
class TagSelector extends StatelessWidget {
  const TagSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => TagSelectorProvider(),
      child: Consumer<TagSelectorProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              const Text(
                'Select a tag',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Expanded(
                child: FutureBuilder<List<tm.Tag>>(
                  future: provider.tags(),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      var data = snap.data!;
                      return SingleChildScrollView(
                        child: Column(
                          children: data.map(modelToTag).toList(),
                        ),
                      );
                    } else if (snap.hasError) {
                      return Text('${snap.error}');
                    } else {
                      return const CircularProgressIndicator.adaptive();
                    }
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: const Text("Create"),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget modelToTag(tm.Tag tag) {
    return Container(
      color: Color(int.parse(tag.color)),
      child: Text(tag.name),
    );
  }
}
