import 'package:equatable/equatable.dart';

class Volume extends Equatable {
  final double value;

  const Volume({required this.value});

  @override
  List<Object> get props => [value];
}
