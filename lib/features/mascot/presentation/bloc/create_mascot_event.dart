part of 'create_mascot_bloc.dart';

abstract class CreateMascotEvent extends Equatable {
  const CreateMascotEvent();

  @override
  List<Object?> get props => [];
}

class SaveMascot extends CreateMascotEvent {}

class Initialize extends CreateMascotEvent {}
