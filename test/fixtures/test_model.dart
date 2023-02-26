// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:isar/isar.dart';
import 'package:mascot/core/clean_architecture/entity.dart' as entity;

part 'test_model.g.dart';

class TestEntity extends entity.EquatableEntity {
  final String name;

  const TestEntity({super.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

@Collection(ignore: {'props', 'stringify'})
class TestModel extends TestEntity {
  const TestModel({Id? id, required String name}) : super(id: id, name: name);
}

@HiveType(typeId: 230)
class HiveTestModel extends TestEntity {
  const HiveTestModel({this.id, required this.name})
      : super(id: id, name: name);

  @override
  @HiveField(0)
  final Id? id;

  @override
  @HiveField(1)
  final String name;
}
