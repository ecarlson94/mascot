import 'package:equatable/equatable.dart';

typedef Id = int;

abstract class Entity {
  Id? id;
}

abstract class EquatableEntity extends Equatable implements Entity {
  @override
  final Id? id;

  @override
  set id(Id? id) => throw Exception('Cannot set id');

  const EquatableEntity({this.id});

  @override
  List<Object?> get props => [id];
}
