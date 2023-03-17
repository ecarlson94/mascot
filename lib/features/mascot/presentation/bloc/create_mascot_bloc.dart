import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error.dart';
import '../../../../core/utils/constants.dart';
import '../../../expressions/domain/entities/expression.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/usecases/save_mascot.dart';

part 'create_mascot_event.dart';
part 'create_mascot_state.dart';

@injectable
class CreateMascotBloc extends Bloc<CreateMascotEvent, CreateMascotState> {
  static const String neutralExpressionName = defaultExpressionName;
  static const String talkingExpressionName = 'Talking';
  static const String neutralExpressionDescription =
      'The default expression of the mascot';
  static const String talkingExpressionDescription =
      'The expression that the mascot uses when talking';

  final SaveMascot _saveMascot;

  CreateMascotBloc(
    this._saveMascot,
  ) : super(const CreateMascotInitial(Mascot.empty)) {
    on<CreateMascotEvent>((event, emit) async {
      if (event is UploadNeutralExpression) {
        await _addExpressionToMascot(
          event.image,
          emit,
          neutralExpressionName,
          neutralExpressionDescription,
        );
      } else if (event is UploadTalkingExpression) {
        await _addExpressionToMascot(
          event.image,
          emit,
          talkingExpressionName,
          talkingExpressionDescription,
        );
      } else if (event is SetMascotName) {
        var mascot = state.mascot.copyWith(name: event.name);
        emit(MascotUpdated(mascot));
        await _updateMascot(mascot, emit);
      }
    });
  }

  Future<void> _addExpressionToMascot(
    XFile image,
    Emitter<CreateMascotState> emit,
    String expressionName,
    String expressionDescription,
  ) async {
    var expression = state.mascot.expressions
        .firstWhere(
          (e) => e.name == expressionName,
          orElse: () => Expression.empty,
        )
        .copyWith(
          name: expressionName,
          description: expressionDescription,
          image: await image.readAsBytes(),
        );
    var unchangedExpressions =
        state.mascot.expressions.where((e) => e.name != expressionName);
    var newMascot = state.mascot.copyWith(
      expressions: {...unchangedExpressions, expression},
    );
    emit(SavingExpression(newMascot));

    await _updateMascot(newMascot, emit);
  }

  Future<void> _updateMascot(
    Mascot mascotToUpdate,
    Emitter<CreateMascotState> emit,
  ) async {
    var mascotOrFailure = await _saveMascot(mascotToUpdate);
    mascotOrFailure.fold(
      (l) async => emit(
        SaveMascotError(
          ErrorCodes.saveMascotFailureCode,
          state.mascot,
        ),
      ),
      (mascot) => emit(MascotUpdated(mascot)),
    );
  }
}
