import 'package:work_hours_tracking/models/tag.dart';

abstract class FindTagRepository {
  Future<Iterable<Tag>> find({
    String? title,
    int? limit,
    int? skip,
  });
}
