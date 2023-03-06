import 'package:isar/isar.dart' as isar;

import '../clean_architecture/entity.dart';
import '../error/exception.dart';
import 'collection_adapter.dart';

class IsarCollectionAdapter<T extends Entity> implements CollectionAdapter<T> {
  final isar.IsarCollection<T> collection;

  IsarCollectionAdapter(this.collection);

  @override
  Future<T> get(isar.Id id) async {
    var item = await collection.get(id);
    if (item == null) {
      throw ArgumentException('${T.toString()} with id of $id not found');
    }
    return item;
  }

  @override
  Future<Id> add(T item) async {
    return await collection.put(item);
  }

  @override
  Future<void> remove(Id id) => collection.delete(id);

  @override
  Future<List<T>> getMany(Iterable<Id> ids) async {
    var items = (await collection.getAll(ids.toList())).whereType<T>().toList();
    if (items.length != ids.length) {
      throw const ArgumentException(
        'ids list contained an id that was not found',
      );
    }

    return items;
  }
}
