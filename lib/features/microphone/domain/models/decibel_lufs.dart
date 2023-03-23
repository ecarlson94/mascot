import 'package:equatable/equatable.dart';

class DecibelLufs extends Equatable {
  final double value;

  const DecibelLufs(this.value);

  @override
  List<Object> get props => [value];
}
