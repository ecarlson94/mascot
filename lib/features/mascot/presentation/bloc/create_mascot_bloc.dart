import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/error/error.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/reactive_image_picker/image_file.dart';
import '../../../expressions/domain/entities/expression.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/usecases/add_mascot.dart';

part 'create_mascot_event.dart';
part 'create_mascot_state.dart';

@injectable
class CreateMascotBloc extends Bloc<CreateMascotEvent, CreateMascotState> {
  static const String neutralExpressionName = defaultExpressionName;
  static const String neutralExpressionDescription =
      'The default expression of the mascot';
  static const String talkingExpressionDescription =
      'The expression that the mascot uses when talking';

  static const String neutralExpressionFormControlName = 'neutralExpression';
  static const String talkingExpressionFormControlName = 'talkingExpression';
  static const String nameFormControlName = 'name';

  final AddMascot _addMascot;

  final FormGroup _form = FormGroup({
    neutralExpressionFormControlName: FormControl<ImageFile>(
      validators: [Validators.required],
    ),
    talkingExpressionFormControlName: FormControl<ImageFile>(
      validators: [Validators.required],
    ),
    nameFormControlName: FormControl<String>(
      validators: [
        Validators.required,
        Validators.pattern(
          r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$',
        ),
      ],
    ),
  });
  ImageFile get _neutralExpressionImage =>
      _form.control(neutralExpressionFormControlName).value as ImageFile;
  ImageFile get _talkingExpressionImage =>
      _form.control(talkingExpressionFormControlName).value as ImageFile;

  CreateMascotBloc(this._addMascot) : super(CreateMascotInitial(none())) {
    on<Initialize>((event, emit) {
      emit(CreateMascotInitial(some(_form)));
    });
    on<SaveMascot>((event, emit) => _saveMascot(emit));
    on<SaveMascotSuccess>(
      (event, emit) => _emitMascotSaved(emit, event.mascot),
    );
    on<SaveMascotFailure>(
      (event, emit) =>
          _emitSaveMascotError(emit, ErrorCodes.saveMascotFailureCode),
    );
  }

  // TODO: Extract to action
  void _emitMascotSaved(Emitter<CreateMascotState> emit, Mascot mascot) {
    _form.markAsEnabled();
    emit(MascotSaved(mascot, some(_form)));
  }

  // TODO: Extract to action
  void _emitSaveMascotError(Emitter<CreateMascotState> emit, int errorCode) =>
      emit(SaveMascotError(errorCode, some(_form)));

  // TODO: Extract to action
  void _saveMascot(
    Emitter<CreateMascotState> emit,
  ) {
    if (!_form.valid) {
      emit(SaveMascotError(ErrorCodes.invalidInputFailureCode, state.form));
    } else {
      _form.markAsDisabled();
      emit(SavingMascot(some(_form)));
      _triggerSaveMascot(emit);
    }
  }

  // TODO: Extract to effect
  void _triggerSaveMascot(Emitter<CreateMascotState> emit) {
    Mascot mascotToUpdate = _createMascotFromForm();

    _addMascot(mascotToUpdate).then(
      (value) => value.fold(
        (failure) => add(SaveMascotFailure(failure)),
        (mascot) => add(SaveMascotSuccess(mascot)),
      ),
    );
  }

  Mascot _createMascotFromForm() => Mascot(
        id: 0,
        name: _form.control(nameFormControlName).value,
        expressions: {
          Expression(
            id: 0,
            name: neutralExpressionName,
            description: neutralExpressionDescription,
            image: _neutralExpressionImage.bytes ?? Uint8List(0),
            priority: 1000,
            activator: ExpressionTriggers.always,
          ),
          Expression(
            id: 0,
            name: talkingExpressionName,
            description: talkingExpressionDescription,
            image: _talkingExpressionImage.bytes ?? Uint8List(0),
            priority: 980,
            activator: ExpressionTriggers.talking,
          ),
        },
      );
}
