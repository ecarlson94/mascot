import 'package:isar/isar.dart' as isar;

import '../clean_architecture/entity.dart';
import 'collection.dart';

abstract class IsarCollection<T extends Entity> implements Collection<T> {
  final isar.IsarCollection<T> collection;

  IsarCollection(this.collection);

  @override
  Future<T> get(isar.Id? id) async {
    var notFound = Exception('${T.toString()} not found');
    if (id == null) throw notFound;

    var item = await collection.get(id);
    if (item == null) throw notFound;
    return item;
  }

  @override
  Future<T> save(T item) async {
    var newId = await collection.put(item);
    return get(newId);
  }
}
