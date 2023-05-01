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
  final int failureCode;

  const SaveMascotFailure(this.failureCode);

  @override
  List<Object?> get props => [failureCode];
}

class InitializeEvent extends CreateMascotEvent {}

class SavingMascotEvent extends CreateMascotEvent {}
