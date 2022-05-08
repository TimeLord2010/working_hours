import 'package:work_hours_tracking/models/tag.dart';

abstract class PutTagRepository {
  Future<int> put(Tag tag);
}
