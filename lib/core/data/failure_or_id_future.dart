import 'package:dartz/dartz.dart';

import '../clean_architecture/entity.dart';
import '../error/failure.dart';

typedef FailureOrIdFuture = Future<Either<Failure, Id>>;
