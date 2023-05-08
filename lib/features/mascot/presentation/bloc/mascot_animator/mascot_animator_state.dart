part of 'mascot_animator_bloc.dart';

abstract class MascotAnimatorState extends Equatable {
  final Option<Expression> expressionOption;

  const MascotAnimatorState(this.expressionOption);

  @override
  List<Object> get props => [expressionOption];
}

class MascotAnimatorInitial extends MascotAnimatorState {
  MascotAnimatorInitial() : super(none());
}

class MascotAnimatorLoading extends MascotAnimatorState {
  const MascotAnimatorLoading(super.expressionOption);
}

class ExpressionChanged extends MascotAnimatorState {
  const ExpressionChanged(super.expressionOption);
}

class MascotAnimatorError extends MascotAnimatorState {
  final int code;

  const MascotAnimatorError(
    this.code,
    super.expressionOption,
  );

  @override
  List<Object> get props => [code, ...super.props];
}
