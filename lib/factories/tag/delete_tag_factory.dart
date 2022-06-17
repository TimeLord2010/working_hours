import 'package:work_hours_tracking/db/tag_repository.dart';
import 'package:work_hours_tracking/repository/tag/delete_tag_repository.dart';

DeleteTagRepository gerateDeleteTag() {
  final tagHandler = TagRepository();
  return tagHandler;
}
