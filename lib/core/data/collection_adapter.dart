import 'package:isar/isar.dart';

abstract class CollectionAdapter<T> {
  Future<T> get(Id? id);
  Future<T> save(T item);
}
