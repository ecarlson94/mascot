import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/error.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/input_converters/convert_xfile_to_image.dart';
import '../../../../core/utils/input_converters/input_converter.dart';
import '../../domain/entities/expression.dart';
import '../../domain/usecases/add_expression.dart';
import '../../domain/usecases/get_expression.dart';

part 'expression_event.dart';
part 'expression_state.dart';

@injectable
class ExpressionBloc extends Bloc<ExpressionEvent, ExpressionState> {
  final GetExpression getExpression;
  final AddExpression addExpression;
  final ConvertXfileToImage convertXfileToImage;

  ExpressionBloc(
    this.getExpression,
    this.addExpression,
    this.convertXfileToImage,
  ) : super(ExpressionInitial()) {
    on<ExpressionEvent>(
      (event, emit) async {
        if (event is SaveExpressionEvent) {
          await _addExpression(
            event.name,
            event.description,
            event.image,
            emit,
          );
        } else if (event is GetExpressionEvent) {
          await _loadExpression(event.id, emit);
        } else if (event is SetExpressionEvent) {
          emit(ExpressionLoaded(event.expression));
        }
      },
    );
  }

  Future<void> _addExpression(
    String name,
    String description,
    XFile image,
    Emitter<ExpressionState> emit,
  ) async {
    var failureOrImage = await convertXfileToImage(image);
    await failureOrImage.fold(
      (l) async => emit(_mapSaveImageFailureToSaveImageError(l)),
      (image) async {
        emit(SavingExpression());
        return (await addExpression(Expression(
          id: 0,
          name: name,
          description: description,
          image: image,
        )))
            .fold(
          (l) => emit(_mapSaveImageFailureToSaveImageError(l)),
          (id) async => _loadExpression(id, emit),
        );
      },
    );
  }

  SaveExpressionError _mapSaveImageFailureToSaveImageError(Failure failure) {
    switch (failure.runtimeType) {
      case InvalidInputFailure:
        return const SaveExpressionError(ErrorCodes.invalidXfileFailureCode);
      case LocalDataSourceFailure:
        return const SaveExpressionError(ErrorCodes.addImageFailureCode);
      default:
        return const SaveExpressionError(ErrorCodes.unknownFailureCode);
    }
  }

  GetExpressionError _mapGetImageFailureToGetImageError(Failure failure) {
    switch (failure.runtimeType) {
      case LocalDataSourceFailure:
        return const GetExpressionError(ErrorCodes.getImageFailureCode);
      default:
        return const GetExpressionError(ErrorCodes.unknownFailureCode);
    }
  }

  Future<void> _loadExpression(
    Id id,
    Emitter<ExpressionState> emit,
  ) async {
    emit(GettingExpression());
    (await getExpression(id)).fold(
      (l) => emit(_mapGetImageFailureToGetImageError(l)),
      (image) => emit(ExpressionLoaded(image)),
    );
  }
}
