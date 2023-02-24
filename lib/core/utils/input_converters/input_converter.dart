import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

abstract class InputConverter<TIn, TOut> {
  Either<Failure, TOut> call(TIn input);
}

class InvalidInputFailure extends Failure {}
