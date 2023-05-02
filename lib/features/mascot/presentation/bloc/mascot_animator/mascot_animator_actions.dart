import 'package:dartz/dartz.dart';
import '../../../../../core/error/error.dart';

import 'mascot_animator_bloc.dart';

MascotAnimatorState setExpression(
  SetExpression event,
  MascotAnimatorState state,
) =>
    ExpressionChanged(some(event.expression));

MascotAnimatorState loadingMascot(
  LoadingMascot event,
  MascotAnimatorState state,
) =>
    MascotAnimatorLoading(state.expressionOption);

MascotAnimatorState streamMascotError(
  StreamMascotError event,
  MascotAnimatorState state,
) =>
    MascotAnimatorError(
      ErrorCodes.loadMascotFailureCode,
      state.expressionOption,
    );
