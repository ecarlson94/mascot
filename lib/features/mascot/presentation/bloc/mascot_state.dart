part of 'mascot_bloc.dart';

abstract class MascotState extends Equatable {
  final Mascot mascot;

  const MascotState(this.mascot);

  @override
  List<Object> get props => [mascot];
}

class MascotInitial extends MascotState {
  const MascotInitial(super.mascot);
}

class MascotLoaded extends MascotState {
  const MascotLoaded(super.mascot);
}
