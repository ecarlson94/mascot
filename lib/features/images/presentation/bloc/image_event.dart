part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class SaveImageEvent extends ImageEvent {
  final XFile image;

  const SaveImageEvent({required this.image});

  @override
  List<Object> get props => [image];
}

class GetImageEvent extends ImageEvent {
  final int id;

  const GetImageEvent({required this.id});

  @override
  List<Object> get props => [id];
}
