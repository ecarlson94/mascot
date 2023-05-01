import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../core/clean_architecture/base_bloc.dart';
import '../../../../../core/error/error.dart';
import '../../../domain/entities/mascot.dart';
import 'create_mascot_actions.dart' as actions;
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
      : super(CreateMascotInitial(none())) {
    createAction(actions.initialize);
    createAction(actions.mascotSaved);
    createAction(actions.saveMascotFailed);
    createAction(actions.savingMascot);

    createEffect(_saveMascotEffect);
  }
}
