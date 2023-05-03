import 'package:dartz/dartz.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../clean_architecture/entity.dart';
import '../error/failure.dart';

typedef FailureOrId = Either<Failure, Id>;
typedef FailureOrIds = Either<Failure, List<Id>>;
typedef FailureOrIdSingle = Single<FailureOrId>;
typedef FailureOrIdsSingle = Single<FailureOrIds>;
