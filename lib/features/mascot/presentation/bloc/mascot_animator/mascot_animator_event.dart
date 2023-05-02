part of 'mascot_animator_bloc.dart';

abstract class MascotAnimatorEvent extends Equatable {
  const MascotAnimatorEvent();

  @override
  List<Object> get props => [];
}

class LoadMascot extends MascotAnimatorEvent {
  final int mascotId;

  const LoadMascot(this.mascotId);

  @override
  List<Object> get props => [mascotId];
}

class SetExpression extends MascotAnimatorEvent {
  final Expression expression;

  const SetExpression(this.expression);

  @override
  List<Object> get props => [expression];
}

class LoadingMascot extends MascotAnimatorEvent {
  const LoadingMascot();
}

class StreamMascotError extends MascotAnimatorEvent {
  const StreamMascotError();
}

class MascotUpdated extends MascotAnimatorEvent {
  final Mascot mascot;

  const MascotUpdated(this.mascot);
}
