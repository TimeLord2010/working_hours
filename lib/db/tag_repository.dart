import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:work_hours_tracking/models/tag.dart';
import 'package:work_hours_tracking/repository/tag/delete_tag_repository.dart';
import 'package:work_hours_tracking/repository/tag/find_tag_repository.dart';
import 'package:work_hours_tracking/repository/tag/put_tag_repository.dart';

class TagRepository with FindTagRepository, DeleteTagRepository, PutTagRepository {
  Future<Isar> get _rep async {
    final dir = await getApplicationSupportDirectory();
    final isar = await Isar.open(
      schemas: [
        TagSchema,
      ],
      directory: dir.path,
    );
    return isar;
  }

  /// Used to better unify close action and possibily
  /// add logs or breakpoints.
  Future<bool> _close(Isar isar) {
    return isar.close();
  }

  @override
  Future<void> delete(int id) async {
    var rep = await _rep;
    try {
      await rep.writeTxn((rep) async {
        await rep.tags.delete(id);
      });
    } finally {
      await _close(rep);
    }
  }

  @override
  Future<Iterable<Tag>> find({
    String? title,
    int? limit,
    int? skip,
  }) async {
    final rep = await _rep;
    try {
      final filter = rep.tags.filter();
      var filtered = title != null ? filter.tagContains(title) : filter.idEqualTo(0);
      var result = await filtered.sortByTag().offset(skip ?? 0).limit(limit ?? 50).findAll();
      return result;
    } finally {
      await _close(rep);
    }
  }

  @override
  Future<int> put(Tag tag) async {
    final rep = await _rep;
    try {
      int? id;
      await rep.writeTxn((rep) async {
        id = await rep.tags.put(tag);
      });
      return id!;
    } finally {
      await _close(rep);
    }
  }
}
