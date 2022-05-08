import 'package:work_hours_tracking/db/tag_repository.dart';
import 'package:work_hours_tracking/repository/tag/put_tag_repository.dart';

PutTagRepository geratePutTag() {
  var tagHandler = TagRepository();
  return tagHandler;
}
