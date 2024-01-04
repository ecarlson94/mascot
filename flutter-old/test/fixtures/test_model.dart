// ignore_for_file: overridden_fields

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mascot/core/clean_architecture/entity.dart';

part 'test_model.freezed.dart';

@freezed
class TestEntity extends Entity with _$TestEntity {
  const factory TestEntity({required Id id, required String name}) =
      _TestEntity;
}

@freezed
class TestModel extends Entity with _$TestModel {
  const factory TestModel({required Id id, required String name}) = _TestModel;
}
