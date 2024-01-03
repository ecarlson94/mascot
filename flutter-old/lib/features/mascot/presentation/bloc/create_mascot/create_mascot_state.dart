part of 'create_mascot_bloc.dart';

class CreateMascotState extends Equatable {
  final Option<FormGroup> form;
  final Option<int> failureCode;
  final Option<Mascot> mascot;
  final bool isSaving;

  const CreateMascotState(
    this.form,
    this.mascot,
    this.failureCode,
    this.isSaving,
  );

  FormGroup get _form => form.getOrElse(getInitialForm);

  @override
  List<Object?> get props => [
        _form.controls.values.map((c) => c.value).toList(),
        mascot,
        failureCode,
        isSaving,
      ];
}
