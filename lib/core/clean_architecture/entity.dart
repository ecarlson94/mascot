import 'package:equatable/equatable.dart';

typedef Id = int;

abstract class Entity extends Equatable {
  final Id id;

  const Entity({required this.id});

  List<Object?> get customProps;

  @override
  List<Object?> get props => [id, ...customProps];
}
