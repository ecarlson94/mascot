import '../clean_architecture/entity.dart';

abstract class CollectionAdapter<T> {
  Future<T> get(Id id);
  Future<Stream<T?>> stream(Id id);
  Future<Id> add(T item);
  Future<void> remove(Id id);
  Future<List<T>> getMany(Iterable<Id> ids);
  Future<bool> contains(Id id);
}
