part of 'mascot_bloc.dart';

abstract class MascotState extends Equatable {
  final Option<Stream<Mascot?>> mascotStreamOption;

  const MascotState(this.mascotStreamOption);

  @override
  List<Object> get props => [mascotStreamOption];
}

class MascotInitial extends MascotState {
  const MascotInitial(super.mascotStreamOption);
}

class MascotLoading extends MascotState {
  const MascotLoading(super.mascotStreamOption);
}

class MascotLoaded extends MascotState {
  const MascotLoaded(super.mascotStreamOption);
}

class MascotError extends MascotState {
  final int code;

  const MascotError(this.code, super.mascotStreamOption);

  @override
  List<Object> get props => [code, super.mascotStreamOption];
}
