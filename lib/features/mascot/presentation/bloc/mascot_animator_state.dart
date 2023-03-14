part of 'mascot_animator_bloc.dart';

abstract class MascotAnimatorState extends Equatable {
  final Option<Map<String, Expression>> expressionMapOption;
  final String expression;

  const MascotAnimatorState(
    this.expressionMapOption,
    this.expression,
  );

  @override
  List<Object> get props => [expressionMapOption, expression];
}

class MascotAnimatorInitial extends MascotAnimatorState {
  const MascotAnimatorInitial(
    super.expressionMapOption,
    super.expression,
  );
}

class MascotAnimatorLoading extends MascotAnimatorState {
  const MascotAnimatorLoading(
    super.expressionMapOption,
    super.expression,
  );
}

class MascotLoaded extends MascotAnimatorState {
  const MascotLoaded(
    super.expressionMapOption,
    super.expression,
  );
}

class MascotAnimatorError extends MascotAnimatorState {
  final int code;

  const MascotAnimatorError(
    this.code,
    super.expressionMapOption,
    super.expression,
  );

  @override
  List<Object> get props => [
        code,
        super.expressionMapOption,
        super.expression,
      ];
}
