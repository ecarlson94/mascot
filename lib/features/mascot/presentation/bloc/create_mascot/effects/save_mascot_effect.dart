import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../../core/clean_architecture/base_bloc.dart';
import '../../../../../../core/error/error.dart';
import '../../../../../../core/utils/constants.dart' as constants;
import '../../../../../../core/widgets/reactive_image_picker/image_file.dart';
import '../../../../../expressions/domain/entities/expression.dart';
import '../../../../domain/entities/mascot.dart';
import '../../../../domain/usecases/add_mascot.dart';
import '../create_mascot_actions.dart';
import '../create_mascot_bloc.dart';

@injectable
class SaveMascotEffect
    extends BlocEffect<CreateMascotEvent, SaveMascot, CreateMascotState> {
  static const String neutralExpressionName = constants.defaultExpressionName;
  static const String talkingExpressionName = constants.talkingExpressionName;
  static const String neutralExpressionDescription =
      'The default expression of the mascot';
  static const String talkingExpressionDescription =
      'The expression that the mascot uses when talking';

  final AddMascot _addMascot;

  SaveMascotEffect(this._addMascot);

  @override
  Stream<CreateMascotEvent> call(
    SaveMascot event,
    CreateMascotState state,
  ) async* {
    var form = state.form.getOrElse(() => initialForm());
    if (!form.valid) {
      yield const SaveMascotFailure(ErrorCodes.invalidInputFailureCode);
    } else {
      yield SavingMascotEvent();
      yield await _triggerSaveMascot(form);
    }
  }

  Future<CreateMascotEvent> _triggerSaveMascot(FormGroup form) async {
    Mascot mascotToUpdate = _createMascotFromForm(form);
    var mascotOrFailure = await _addMascot(mascotToUpdate);
    return mascotOrFailure.fold(
      (failure) => const SaveMascotFailure(ErrorCodes.saveMascotFailureCode),
      (mascot) => SaveMascotSuccess(mascot),
    );
  }

  // TODO: convert to extension method
  TReturn _getControlValue<TReturn>(FormGroup form, String controlName) =>
      form.control(controlName).value as TReturn;

  Mascot _createMascotFromForm(FormGroup form) => Mascot(
        id: 0,
        name: _getControlValue<String>(
            form, CreateMascotBloc.nameFormControlName),
        expressions: {
          Expression(
            id: 0,
            name: neutralExpressionName,
            description: neutralExpressionDescription,
            image: (_getControlValue<ImageFile>(
                  form,
                  CreateMascotBloc.neutralExpressionFormControlName,
                )).bytes ??
                Uint8List(0),
            priority: 1000,
            activator: ExpressionTriggers.always,
          ),
          Expression(
            id: 0,
            name: talkingExpressionName,
            description: talkingExpressionDescription,
            image: (_getControlValue<ImageFile>(
                  form,
                  CreateMascotBloc.talkingExpressionFormControlName,
                )).bytes ??
                Uint8List(0),
            priority: 980,
            activator: ExpressionTriggers.talking,
          ),
        },
      );
}
