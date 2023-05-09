import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

typedef Try<T> = Either<Failure, T>;

abstract class Failure extends Equatable {
  final Exception? exception;

  const Failure(this.exception);

  @override
  List<Object?> get props => [];
}

class LocalDataSourceFailure extends Failure {
  const LocalDataSourceFailure(super.exception);
}

class InvalidArgumentFailure extends Failure {
  const InvalidArgumentFailure(super.exception);
}

class NoMicrophonePermissionFailure extends Failure {
  const NoMicrophonePermissionFailure(super.exception);
}

class MicrophoneFailure extends Failure {
  const MicrophoneFailure(super.exception);
}
