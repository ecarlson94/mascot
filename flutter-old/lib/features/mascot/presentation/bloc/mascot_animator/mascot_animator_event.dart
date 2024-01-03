part of 'mascot_animator_bloc.dart';

abstract class MascotAnimatorEvent extends Equatable {
  const MascotAnimatorEvent();

  @override
  List<Object> get props => [];
}

class LoadMascotEvent extends MascotAnimatorEvent {
  final int mascotId;

  const LoadMascotEvent(this.mascotId);

  @override
  List<Object> get props => [mascotId];
}

class SetExpressionEvent extends MascotAnimatorEvent {
  final Expression expression;

  const SetExpressionEvent(this.expression);

  @override
  List<Object> get props => [expression];
}

class LoadingMascotEvent extends MascotAnimatorEvent {
  const LoadingMascotEvent();
}

class StreamMascotErrorEvent extends MascotAnimatorEvent {
  const StreamMascotErrorEvent();
}

class MascotUpdatedEvent extends MascotAnimatorEvent {
  final Mascot mascot;

  const MascotUpdatedEvent(this.mascot);
}
