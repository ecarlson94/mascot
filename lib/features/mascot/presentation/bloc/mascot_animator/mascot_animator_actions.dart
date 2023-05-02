import 'package:dartz/dartz.dart';

import '../../../../../core/error/error.dart';
import 'mascot_animator_bloc.dart';

MascotAnimatorState setExpression(
  SetExpressionEvent event,
  MascotAnimatorState state,
) =>
    ExpressionChanged(some(event.expression));

MascotAnimatorState loadingMascot(
  LoadingMascotEvent event,
  MascotAnimatorState state,
) =>
    MascotAnimatorLoading(state.expressionOption);

MascotAnimatorState streamMascotError(
  StreamMascotErrorEvent event,
  MascotAnimatorState state,
) =>
    MascotAnimatorError(
      ErrorCodes.loadMascotFailureCode,
      state.expressionOption,
    );
