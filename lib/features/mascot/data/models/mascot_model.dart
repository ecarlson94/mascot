import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../expressions/data/models/expression_model.dart';

part 'mascot_model.freezed.dart';

@freezed
class MascotModel extends Entity with _$MascotModel {
  const factory MascotModel({
    required Id id,
    required String name,
    required Set<ExpressionModel> expressions,
  }) = _MascotModel;
}
