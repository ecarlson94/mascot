import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/input_converters/convert_xfile_to_image.dart';
import '../../../expressions/domain/entities/expression.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/usecases/get_mascot.dart';
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

  final ConvertXfileToImage _convertXfileToImage;
  final SaveMascot _saveMascot;
  final GetMascot _getMascot;

  CreateMascotBloc(
    this._convertXfileToImage,
    this._saveMascot,
    this._getMascot,
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
    var imageOrFailure = await _convertXfileToImage(image);
    await imageOrFailure.fold(
      (l) async => emit(
        UploadExpressionError(
          ErrorCodes.invalidXfileFailureCode,
          state.mascot,
        ),
      ),
      (image) async {
        var expression = state.mascot.expressions
            .firstWhere(
              (e) => e.name == expressionName,
              orElse: () => Expression.empty,
            )
            .copyWith(
              name: expressionName,
              description: expressionDescription,
              image: image,
            );
        var unchangedExpressions =
            state.mascot.expressions.where((e) => e.name != expressionName);
        var mascot = state.mascot.copyWith(
          expressions: [...unchangedExpressions, expression],
        );
        emit(SavingExpression(mascot));

        await _updateMascot(mascot, emit);
      },
    );
  }

  Future<void> _updateMascot(
    Mascot mascot,
    Emitter<CreateMascotState> emit,
  ) async {
    var mascotIdOrFailure = await _saveMascot(mascot);
    await mascotIdOrFailure.fold(
      (l) async => emit(
        SaveMascotError(
          ErrorCodes.saveMascotFailureCode,
          mascot,
        ),
      ),
      (mascotId) async {
        var mascotOrFailure = await _getMascot(mascotId);
        await mascotOrFailure.fold(
          (l) async => emit(
            SaveMascotError(
              ErrorCodes.getMascotFailureCode,
              mascot,
            ),
          ),
          (updatedMascot) async => emit(MascotUpdated(updatedMascot)),
        );
      },
    );
  }
}
