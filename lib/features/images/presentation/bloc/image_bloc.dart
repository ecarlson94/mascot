import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/error.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/input_converters/convert_xfile_to_image.dart';
import '../../../../core/utils/input_converters/input_converter.dart';
import '../../domain/entities/image.dart';
import '../../domain/usecases/get_image.dart';
import '../../domain/usecases/save_image.dart';

part 'image_event.dart';
part 'image_state.dart';

const int invalidXfileFailureCode = 100;
const int saveImageFailureCode = 101;
const int getImageFailureCode = 102;

@injectable
class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc(
    GetImage getImage,
    SaveImage saveImage,
    ConvertXfileToImage convertXfileToImage,
  ) : super(ImageInitial()) {
    on<ImageEvent>(
      (event, emit) async {
        if (event is SaveImageEvent) {
          await _saveImage(convertXfileToImage, event, emit, saveImage);
        } else if (event is GetImageEvent) {
          await _getImage(emit, getImage, event);
        }
      },
    );
  }

  Future<void> _saveImage(
    ConvertXfileToImage convertXfileToImage,
    SaveImageEvent event,
    Emitter<ImageState> emit,
    SaveImage saveImage,
  ) async {
    var failureOrImage = await convertXfileToImage(event.image);
    await failureOrImage.fold(
      (l) async => emit(_mapSaveImageFailureToSaveImageError(l)),
      (r) async {
        emit(SavingImage());
        return (await saveImage(r)).fold(
          (l) => emit(_mapSaveImageFailureToSaveImageError(l)),
          (r) => emit(ImageLoaded(r)),
        );
      },
    );
  }

  SaveImageError _mapSaveImageFailureToSaveImageError(Failure failure) {
    switch (failure.runtimeType) {
      case InvalidInputFailure:
        return const SaveImageError(invalidXfileFailureCode);
      case LocalDataSourceFailure:
        return const SaveImageError(saveImageFailureCode);
      default:
        return const SaveImageError(0);
    }
  }

  Future<void> _getImage(
    Emitter<ImageState> emit,
    GetImage getImage,
    GetImageEvent event,
  ) async {
    emit(GettingImage());
    (await getImage(event.id)).fold(
      (l) => emit(_mapGetImageFailureToGetImageError(l)),
      (r) => emit(ImageLoaded(r)),
    );
  }
}

GetImageError _mapGetImageFailureToGetImageError(Failure failure) {
  switch (failure.runtimeType) {
    case LocalDataSourceFailure:
      return const GetImageError(getImageFailureCode);
    default:
      return const GetImageError(0);
  }
}
