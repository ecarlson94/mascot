import 'package:hive/hive.dart';

import '../clean_architecture/entity.dart';
import 'collection_adapter.dart';

class HiveCollectionAdapter<T extends Entity> implements CollectionAdapter<T> {
  final Box<T> collection;

  HiveCollectionAdapter(this.collection);

  @override
  Future<T> get(Id id) async {
    var notFound = Exception('${T.toString()} not found');
    if (id == 0) throw notFound;

    var item = collection.get(id);
    if (item == null) throw notFound;
    return item;
  }

  @override
  Future<Id> add(T item) async {
    var id = item.id == 0 ? collection.length + 1 : item.id;
    await collection.put(id, item);
    return id;
  }
}
