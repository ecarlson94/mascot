import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

abstract class InputConverter<TIn, TOut> {
  FutureOr<Either<Failure, TOut>> call(TIn input);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.exception);
}
