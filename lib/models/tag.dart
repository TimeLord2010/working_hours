import 'package:isar/isar.dart';

part 'tag.g.dart';

@Collection()
class Tag {
  int id = Isar.autoIncrement;

  @Index()
  late String tag;

  late String color;
}
