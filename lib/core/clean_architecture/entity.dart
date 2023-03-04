import 'package:equatable/equatable.dart';

typedef Id = int;

abstract class Entity {
  Id get id;
}

abstract class EquatableEntity extends Equatable implements Entity {
  @override
  final Id id;

  const EquatableEntity({required this.id});
}
