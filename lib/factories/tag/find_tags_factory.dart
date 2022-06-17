import 'package:work_hours_tracking/db/tag_repository.dart';
import 'package:work_hours_tracking/repository/tag/find_tag_repository.dart';

FindTagRepository gerateFindTags() {
  var tagHandler = TagRepository();
  return tagHandler;
}
