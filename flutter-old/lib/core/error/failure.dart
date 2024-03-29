import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

typedef Try<T> = Either<Failure, T>;

abstract class Failure extends Equatable {
  final Exception? exception;

  const Failure(this.exception);

  @override
  List<Object?> get props => [];
}
