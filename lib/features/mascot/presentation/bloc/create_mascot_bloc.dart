import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/input_converters/convert_xfile_to_image.dart';
import '../../../../core/utils/input_converters/input_converter.dart';
import '../../../expressions/domain/entities/expression.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/usecases/get_mascot.dart';
import '../../domain/usecases/save_mascot.dart';

part 'create_mascot_event.dart';
part 'create_mascot_state.dart';

@injectable
class CreateMascotBloc extends Bloc<CreateMascotEvent, CreateMascotState> {
  static const String neutralExpressionName = 'Neutral';
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
      (l) async => emit(_mapXFileInputFailure(l)),
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
      (l) async => emit(_saveMascotFailure(l)),
      (mascotId) async {
        var mascotOrFailure = await _getMascot(mascotId);
        await mascotOrFailure.fold(
          (l) async => emit(_saveMascotFailure(l)),
          (mascot) async => emit(CreateMascotInitial(mascot)),
        );
      },
    );
  }

  UploadExpressionError _mapXFileInputFailure(Failure failure) {
    switch (failure.runtimeType) {
      case InvalidInputFailure:
        return UploadExpressionError(
          ErrorCodes.invalidXfileFailureCode,
          state.mascot,
        );
      default:
        return UploadExpressionError(
          ErrorCodes.unknownFailureCode,
          state.mascot,
        );
    }
  }

  SaveMascotError _saveMascotFailure(Failure failure) {
    switch (failure.runtimeType) {
      case LocalDataSourceFailure:
        return SaveMascotError(
          ErrorCodes.saveMascotFailureCode,
          state.mascot,
        );
      default:
        return SaveMascotError(
          ErrorCodes.unknownFailureCode,
          state.mascot,
        );
    }
  }
}
