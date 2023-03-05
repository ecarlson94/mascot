part of 'create_mascot_bloc.dart';

abstract class CreateMascotState extends Equatable {
  final Mascot mascot;

  const CreateMascotState(this.mascot);

  @override
  List<Object> get props => [mascot];
}

class CreateMascotInitial extends CreateMascotState {
  const CreateMascotInitial(super.mascot);
}

abstract class CreateMascotError extends CreateMascotState
    implements ErrorState {
  @override
  final int code;

  const CreateMascotError(this.code, super.mascot);

  @override
  List<Object> get props => [code, super.mascot];
}

class UploadExpressionError extends CreateMascotError {
  const UploadExpressionError(super.code, super.mascot);
}

class SaveMascotError extends CreateMascotError {
  const SaveMascotError(super.code, super.mascot);
}
