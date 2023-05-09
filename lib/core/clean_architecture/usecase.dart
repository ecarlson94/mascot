import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Single<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseStream<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
