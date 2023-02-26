import 'package:hive/hive.dart';

import '../clean_architecture/entity.dart';
import 'collection.dart';

abstract class HiveCollection<T extends Entity> implements Collection<T> {
  final CollectionBox<T> collection;
  int _length = 0;
  bool _lengthAquired = false;

  HiveCollection(this.collection);

  @override
  Future<T> get(Id? id) async {
    var notFound = Exception('${T.toString()} not found');
    if (id == null) throw notFound;

    var item = await collection.get(id.toString());
    if (item == null) throw notFound;
    return item;
  }

  @override
  Future<T> save(T item) async {
    if (!_lengthAquired) {
      _length = (await collection.getAllKeys()).length;
      _lengthAquired = true;
    }

    var id = item.id ?? _length + 1;
    await collection.put(id.toString(), item);
    _length++;

    return await get(id);
  }
}
