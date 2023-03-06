import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Image extends Equatable {
  final String name;
  final Uint8List data;

  const Image({required this.name, required this.data});

  @override
  List<Object?> get props => [name, data];

  static Image empty = Image(name: '', data: Uint8List(0));
}
