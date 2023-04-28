part of 'create_mascot_bloc.dart';

abstract class CreateMascotEvent extends Equatable {
  const CreateMascotEvent();

  @override
  List<Object?> get props => [];
}

class SaveMascot extends CreateMascotEvent {}

class SaveMascotSuccess extends CreateMascotEvent {
  final Mascot mascot;

  const SaveMascotSuccess(this.mascot);

  @override
  List<Object?> get props => [mascot];
}

class SaveMascotFailure extends CreateMascotEvent {
  final Failure failure;

  const SaveMascotFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}

class Initialize extends CreateMascotEvent {}
