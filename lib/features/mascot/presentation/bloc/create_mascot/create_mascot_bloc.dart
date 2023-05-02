import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../core/reactive/base_bloc.dart';
import '../../../domain/entities/mascot.dart';
import 'create_mascot_actions.dart' as actions;
import 'create_mascot_actions.dart';
import 'effects/save_mascot_effect.dart';

part 'create_mascot_event.dart';
part 'create_mascot_state.dart';

@injectable
class CreateMascotBloc extends BaseBloc<CreateMascotEvent, CreateMascotState> {
  static const String neutralExpressionFormControlName = 'neutralExpression';
  static const String talkingExpressionFormControlName = 'talkingExpression';
  static const String nameFormControlName = 'name';

  final SaveMascotEffect _saveMascotEffect;

  CreateMascotBloc(this._saveMascotEffect)
      : super(CreateMascotState(
          none(),
          none(),
          none(),
          false,
        )) {
    createAction(actions.initialize);

    createEffect(_saveMascotEffect);
    createAction(actions.savingMascot);
    createAction(actions.saveMascotSuccess);
    createAction(actions.saveMascotFailed);
  }
}
