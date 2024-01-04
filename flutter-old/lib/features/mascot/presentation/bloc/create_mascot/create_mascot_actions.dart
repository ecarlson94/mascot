import 'package:dartz/dartz.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../core/widgets/reactive_image_picker/image_file.dart';
import 'create_mascot_bloc.dart';

FormGroup getInitialForm() => FormGroup({
      CreateMascotBloc.neutralExpressionFormControlName: FormControl<ImageFile>(
        validators: [Validators.required],
      ),
      CreateMascotBloc.talkingExpressionFormControlName: FormControl<ImageFile>(
        validators: [Validators.required],
      ),
      CreateMascotBloc.nameFormControlName: FormControl<String>(
        validators: [
          Validators.required,
          Validators.pattern(
            r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$',
          ),
        ],
      ),
    });

CreateMascotState get initialCreateMascotState =>
    CreateMascotState(some(getInitialForm()), none(), none(), false);

CreateMascotState initialize(
  InitializeEvent event,
  CreateMascotState state,
) =>
    initialCreateMascotState;

CreateMascotState saveMascotSuccess(
  SaveMascotSuccessEvent event,
  CreateMascotState state,
) {
  var form = state.form.getOrElse(getInitialForm);
  form.markAsEnabled();

  return CreateMascotState(
    some(form),
    some(event.mascot),
    none(),
    false,
  );
}

CreateMascotState saveMascotFailed(
  SaveMascotFailureEvent event,
  CreateMascotState state,
) {
  var form = state.form.getOrElse(getInitialForm);
  form.markAsEnabled();

  return CreateMascotState(
    some(form),
    state.mascot,
    some(event.failureCode),
    false,
  );
}

CreateMascotState savingMascot(
  SavingMascotEvent event,
  CreateMascotState state,
) {
  var form = state.form.getOrElse(getInitialForm);
  form.markAsDisabled();

  return CreateMascotState(
    some(form),
    state.mascot,
    state.failureCode,
    true,
  );
}
