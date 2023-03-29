import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../expressions/domain/entities/expression.dart';

part 'mascot.freezed.dart';

@freezed
class Mascot extends Entity with _$Mascot {
  const factory Mascot({
    required Id id,
    required String name,
    required Set<Expression> expressions,
  }) = _Mascot;

  static const Mascot empty = Mascot(
    id: 0,
    name: '',
    expressions: {},
  );
}
