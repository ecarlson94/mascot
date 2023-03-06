import 'package:equatable/equatable.dart';

typedef Id = int;

abstract class Entity<T> {
  Id get id;

  T copyWithId(Id id);
}

abstract class EquatableEntity<T> extends Equatable implements Entity<T> {
  @override
  final Id id;

  const EquatableEntity({required this.id});
}
