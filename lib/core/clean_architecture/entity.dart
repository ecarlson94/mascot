import 'package:equatable/equatable.dart';

abstract class Entity extends Equatable {
  final int id;

  const Entity({required this.id, required List<Object?> props})
      : _props = props;

  final List<Object?> _props;

  @override
  List<Object?> get props => [id, ..._props];
}
