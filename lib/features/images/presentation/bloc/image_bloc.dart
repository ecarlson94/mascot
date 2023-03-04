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
import '../../domain/usecases/add_image.dart';
import '../../domain/usecases/get_image.dart';

part 'image_event.dart';
part 'image_state.dart';

const int invalidXfileFailureCode = 100;
const int addImageFailureCode = 101;
const int getImageFailureCode = 102;

@injectable
class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final GetImage getImage;
  final AddImage addImage;
  final ConvertXfileToImage convertXfileToImage;

  ImageBloc(
    this.getImage,
    this.addImage,
    this.convertXfileToImage,
  ) : super(ImageInitial()) {
    on<ImageEvent>(
      (event, emit) async {
        if (event is SaveImageEvent) {
          await _addImage(event.image, emit);
        } else if (event is GetImageEvent) {
          await _loadImage(event.id, emit);
        } else if (event is SetImageEvent) {
          emit(ImageLoaded(event.image));
        }
      },
    );
  }

  Future<void> _addImage(
    XFile image,
    Emitter<ImageState> emit,
  ) async {
    var failureOrImage = await convertXfileToImage(image);
    await failureOrImage.fold(
      (l) async => emit(_mapSaveImageFailureToSaveImageError(l)),
      (image) async {
        emit(SavingImage());
        return (await addImage(image)).fold(
          (l) => emit(_mapSaveImageFailureToSaveImageError(l)),
          (id) async => _loadImage(id, emit),
        );
      },
    );
  }

  SaveImageError _mapSaveImageFailureToSaveImageError(Failure failure) {
    switch (failure.runtimeType) {
      case InvalidInputFailure:
        return const SaveImageError(invalidXfileFailureCode);
      case LocalDataSourceFailure:
        return const SaveImageError(addImageFailureCode);
      default:
        return const SaveImageError(0);
    }
  }

  Future<void> _loadImage(
    Id? id,
    Emitter<ImageState> emit,
  ) async {
    emit(GettingImage());
    (await getImage(id)).fold(
      (l) => emit(_mapGetImageFailureToGetImageError(l)),
      (image) => emit(ImageLoaded(image)),
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
