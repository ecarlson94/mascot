import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../../core/reactive/base_bloc.dart';
import '../../../../../../core/error/error.dart';
import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/constants.dart' as constants;
import '../../../../../../core/widgets/reactive_image_picker/image_file.dart';
import '../../../../../expressions/domain/entities/expression.dart';
import '../../../../domain/entities/mascot.dart';
import '../../../../domain/usecases/add_mascot.dart';
import '../create_mascot_actions.dart';
import '../create_mascot_bloc.dart';

@injectable
class SaveMascotEffect
    extends BlocEffect<CreateMascotEvent, SaveMascotEvent, CreateMascotState> {
  static const String neutralExpressionName = constants.defaultExpressionName;
  static const int neutralExpressionPriority = 1000;
  static const String neutralExpressionDescription =
      'The default expression of the mascot';
  static const String talkingExpressionName = constants.talkingExpressionName;
  static const int talkingExpressionPriority = 980;
  static const String talkingExpressionDescription =
      'The expression that the mascot uses when talking';

  final AddMascot _addMascot;

  SaveMascotEffect(this._addMascot);

  @override
  Stream<CreateMascotEvent> call(
    SaveMascotEvent event,
    CreateMascotState state,
  ) async* {
    var form = state.form.getOrElse(getInitialForm);
    if (!form.valid) {
      yield const SaveMascotFailureEvent(ErrorCodes.invalidInputFailureCode);
    } else {
      yield SavingMascotEvent();
      yield await _triggerSaveMascot(form);
    }
  }

  Future<CreateMascotEvent> _triggerSaveMascot(FormGroup form) async {
    var mascotToSave = _createMascotFromForm(form);

    var mascotOrFailure = await _addMascot(mascotToSave);
    return mascotOrFailure.fold(
      (failure) =>
          const SaveMascotFailureEvent(ErrorCodes.saveMascotFailureCode),
      (mascot) => SaveMascotSuccessEvent(mascot),
    );
  }

  Mascot _createMascotFromForm(FormGroup form) => Mascot(
        id: 0,
        name: form.controlValue<String>(CreateMascotBloc.nameFormControlName),
        expressions: {
          Expression(
            id: 0,
            name: neutralExpressionName,
            description: neutralExpressionDescription,
            image: form
                .controlValue<ImageFile>(
                  CreateMascotBloc.neutralExpressionFormControlName,
                )
                .bytes,
            priority: neutralExpressionPriority,
            activator: ExpressionTriggers.always,
          ),
          Expression(
            id: 0,
            name: talkingExpressionName,
            description: talkingExpressionDescription,
            image: form
                .controlValue<ImageFile>(
                  CreateMascotBloc.talkingExpressionFormControlName,
                )
                .bytes,
            priority: talkingExpressionPriority,
            activator: ExpressionTriggers.talking,
          ),
        },
      );
}
