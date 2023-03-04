import 'package:hive/hive.dart';

import '../clean_architecture/entity.dart';
import 'collection_adapter.dart';

class HiveCollectionAdapter<T extends Entity> implements CollectionAdapter<T> {
  final Box<T> collection;

  HiveCollectionAdapter(this.collection);

  @override
  Future<T> get(Id? id) async {
    var notFound = Exception('${T.toString()} not found');
    if (id == null) throw notFound;

    var item = collection.get(id);
    if (item == null) throw notFound;
    return item;
  }

  @override
  Future<T> save(T item) async {
    var id = item.id ?? collection.length + 1;
    await collection.put(id, item);

    return await get(id);
  }
}
