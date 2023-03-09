part of 'mascot_bloc.dart';

abstract class MascotEvent extends Equatable {
  const MascotEvent();

  @override
  List<Object> get props => [];
}

class LoadMascotStream extends MascotEvent {
  final int mascotId;

  const LoadMascotStream(this.mascotId);

  @override
  List<Object> get props => [mascotId];
}
