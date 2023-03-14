// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:isar/isar.dart';
import 'package:mascot/core/clean_architecture/entity.dart' as entity;
import 'package:mascot/core/data/hive/hive_model.dart';

part 'test_model.g.dart';

class TestEntity extends entity.Entity {
  final String name;

  const TestEntity({required super.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

@Collection(ignore: {'props', 'stringify'})
class TestModel extends TestEntity {
  const TestModel({required Id id, required String name})
      : super(id: id, name: name);
}

@HiveType(typeId: 230)
class HiveTestModel extends TestModel implements HiveModel<HiveTestModel> {
  const HiveTestModel({required this.id, required this.name})
      : super(id: id, name: name);

  @override
  @HiveField(0)
  final Id id;

  @override
  @HiveField(1)
  final String name;

  @override
  HiveTestModel copyWithId(entity.Id id) => HiveTestModel(id: id, name: name);
}
