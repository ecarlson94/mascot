part of 'create_mascot_bloc.dart';

abstract class CreateMascotEvent extends Equatable {
  const CreateMascotEvent();

  @override
  List<Object?> get props => [];
}

class UploadNeutralExpression extends CreateMascotEvent {
  final XFile image;

  const UploadNeutralExpression(this.image);

  @override
  List<Object?> get props => [image];
}

class UploadTalkingExpression extends CreateMascotEvent {
  final XFile image;

  const UploadTalkingExpression(this.image);

  @override
  List<Object?> get props => [image];
}

class SetMascotName extends CreateMascotEvent {
  final String name;

  const SetMascotName(this.name);

  @override
  List<Object?> get props => [name];
}

class SaveMascot extends CreateMascotEvent {}
