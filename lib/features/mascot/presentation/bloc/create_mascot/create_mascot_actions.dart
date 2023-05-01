import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../core/error/error.dart';
import '../../../../../core/widgets/reactive_image_picker/image_file.dart';
import 'create_mascot_bloc.dart';

FormGroup initialForm() => FormGroup({
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

void initialize(
  InitializeEvent event,
  CreateMascotState state,
  Emitter<CreateMascotState> emit,
) {
  emit(CreateMascotInitial(some(initialForm())));
}

void mascotSaved(
  SaveMascotSuccess event,
  CreateMascotState state,
  Emitter<CreateMascotState> emit,
) {
  var form = state.form.getOrElse(() => initialForm());
  form.markAsEnabled();

  emit(MascotSaved(event.mascot, some(form)));
}

void saveMascotFailed(
  SaveMascotFailure event,
  CreateMascotState state,
  Emitter<CreateMascotState> emit,
) {
  emit(SaveMascotError(ErrorCodes.saveMascotFailureCode, state.form));
}

void savingMascot(
  SavingMascotEvent event,
  CreateMascotState state,
  Emitter<CreateMascotState> emit,
) {
  var form = state.form.getOrElse(() => initialForm());
  form.markAsDisabled();

  emit(SavingMascot(some(form)));
}
