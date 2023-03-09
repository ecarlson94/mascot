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

class SetMascot extends MascotAnimatorEvent {
  final Mascot mascot;

  const SetMascot(this.mascot);

  @override
  List<Object> get props => [mascot];
}
