import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocalDataSourceFailure extends Failure {}

class InvalidArgumentFailure extends Failure {}

class NoMicrophonePermissionFailure extends Failure {}

class MicrophoneFailure extends Failure {}
