import 'package:isar/isar.dart';

abstract class Collection<T> {
  Future<T> get(Id? id);
  Future<T> save(T item);
}
