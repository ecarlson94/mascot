part of 'create_mascot_bloc.dart';

abstract class CreateMascotEvent extends Equatable {
  const CreateMascotEvent();

  @override
  List<Object?> get props => [];
}

class SaveMascotEvent extends CreateMascotEvent {}

class SaveMascotSuccessEvent extends CreateMascotEvent {
  final Mascot mascot;

  const SaveMascotSuccessEvent(this.mascot);

  @override
  List<Object?> get props => [mascot];
}

class SaveMascotFailureEvent extends CreateMascotEvent {
  final int failureCode;

  const SaveMascotFailureEvent(this.failureCode);

  @override
  List<Object?> get props => [failureCode];
}

class InitializeEvent extends CreateMascotEvent {}

class SavingMascotEvent extends CreateMascotEvent {}
