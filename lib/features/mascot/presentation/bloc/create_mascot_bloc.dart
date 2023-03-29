import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/image_file.dart';

import '../../../../core/error/error.dart';
import '../../../../core/utils/constants.dart';
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
  ImageFile get _neutralExpression =>
      _form.control(neutralExpressionFormControlName).value as ImageFile;
  ImageFile get _talkingExpression =>
      _form.control(talkingExpressionFormControlName).value as ImageFile;

  CreateMascotBloc(this._addMascot) : super(CreateMascotInitial(none())) {
    on<CreateMascotEvent>((event, emit) async {
      if (event is Initialize) {
        emit(
          CreateMascotInitial(
            some(_form),
          ),
        );
      } else if (event is SaveMascot) {
        await _saveMascot(emit);
      }
    });
  }

  Future<void> _saveMascot(
    Emitter<CreateMascotState> emit,
  ) async {
    if (!_form.valid) {
      emit(SaveMascotError(ErrorCodes.invalidInputFailureCode, state.form));
      return;
    }

    Mascot mascotToUpdate = await _createMascotFromForm();

    var mascotOrFailure = await _addMascot(mascotToUpdate);
    mascotOrFailure.fold(
      (l) async => emit(
        SaveMascotError(
          ErrorCodes.saveMascotFailureCode,
          state.form,
        ),
      ),
      (mascot) => emit(MascotSaved(mascot, state.form)),
    );
  }

  Future<Mascot> _createMascotFromForm() async => Mascot(
        id: 0,
        name: _form.control(nameFormControlName).value,
        expressions: {
          Expression(
            id: 0,
            name: neutralExpressionName,
            description: neutralExpressionDescription,
            image: await _neutralExpression.image!.readAsBytes(),
          ),
          Expression(
            id: 0,
            name: talkingExpressionName,
            description: talkingExpressionDescription,
            image: await _talkingExpression.image!.readAsBytes(),
          ),
        },
      );
}
