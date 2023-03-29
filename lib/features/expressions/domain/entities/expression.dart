import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/clean_architecture/entity.dart';

part 'expression.freezed.dart';

@freezed
class Expression extends Entity with _$Expression {
  const factory Expression({
    required Id id,
    required String name,
    required String description,
    required Uint8List image,
  }) = _Expression;

  static Expression empty = Expression(
    id: 0,
    name: '',
    description: '',
    image: Uint8List(0),
  );
}
