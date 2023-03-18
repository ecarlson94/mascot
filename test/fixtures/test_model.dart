// ignore_for_file: overridden_fields

import 'package:mascot/core/clean_architecture/entity.dart' as entity;

class TestEntity extends entity.Entity {
  final String name;

  const TestEntity({required super.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class TestModel extends TestEntity {
  const TestModel({required super.id, required super.name});
}
