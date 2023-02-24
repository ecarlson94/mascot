part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageLoaded extends ImageState {
  final Image image;

  const ImageLoaded(this.image);

  @override
  List<Object> get props => [image];
}

class SavingImage extends ImageState {}

class SaveImageError extends ImageState implements ErrorState {
  @override
  final int code;

  const SaveImageError(this.code);

  @override
  List<Object> get props => [code];
}

class GettingImage extends ImageState {}

class GetImageError extends ImageState implements ErrorState {
  @override
  final int code;

  const GetImageError(this.code);

  @override
  List<Object> get props => [code];
}
