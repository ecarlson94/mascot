import 'package:equatable/equatable.dart';

typedef Id = int?;

abstract class Entity extends Equatable {
  final Id id;

  const Entity({required this.id, required List<Object?> props})
      : _props = props;

  final List<Object?> _props;

  @override
  List<Object?> get props => [id, ..._props];
}
