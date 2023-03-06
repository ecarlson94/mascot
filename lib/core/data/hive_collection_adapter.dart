import 'package:hive/hive.dart';

import '../clean_architecture/entity.dart';
import '../error/exception.dart';
import 'collection_adapter.dart';

class HiveCollectionAdapter<T extends Entity> implements CollectionAdapter<T> {
  final Box<T> collection;

  HiveCollectionAdapter(this.collection);

  @override
  Future<T> get(Id id) async {
    var item = collection.get(id);
    if (item == null) {
      throw ArgumentException('${T.toString()} with id of $id not found');
    }
    return item.copyWithId(id);
  }

  @override
  Future<Id> add(T item) async {
    var id = item.id == 0 ? collection.length + 1 : item.id;
    var itemWithId = item.copyWithId(id);
    await collection.put(id, itemWithId);
    return id;
  }

  @override
  Future<void> remove(Id id) => collection.delete(id);

  @override
  Future<List<T>> getMany(Iterable<Id> ids) =>
      Future.wait(ids.map((id) => get(id)).toList());
}
