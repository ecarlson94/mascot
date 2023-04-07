import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/clean_architecture/entity.dart';

part 'expression_model.freezed.dart';

@freezed
class ExpressionModel extends Entity with _$ExpressionModel {
  const factory ExpressionModel({
    required Id id,
    required String name,
    required String description,
    required Uint8List image,
  }) = _ExpressionModel;

  factory ExpressionModel.empty() =>
      ExpressionModel(id: 0, name: '', description: '', image: Uint8List(0));
}
