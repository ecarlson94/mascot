part of 'create_mascot_bloc.dart';

abstract class CreateMascotState extends Equatable {
  final Option<FormGroup> form;

  const CreateMascotState(this.form);

  @override
  List<Object> get props => [form];
}

class CreateMascotInitial extends CreateMascotState {
  const CreateMascotInitial(super.form);
}

class SavingMascot extends CreateMascotState {
  const SavingMascot(super.form);
}

class MascotSaved extends CreateMascotState {
  final Mascot mascot;

  const MascotSaved(this.mascot, super.form);

  @override
  List<Object> get props => [mascot, form];
}

abstract class CreateMascotError extends CreateMascotState
    implements ErrorState {
  @override
  final int code;

  const CreateMascotError(this.code, super.form);

  @override
  List<Object> get props => [code];
}

class SaveMascotError extends CreateMascotError {
  const SaveMascotError(super.code, super.form);
}
