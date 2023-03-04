import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/repositories/mascots_repository.dart';

@LazySingleton(as: MascotsRepository)
class MascotsRepositoryImpl implements MascotsRepository {
  MascotsRepositoryImpl();

  @override
  Future<Either<Failure, Id>> addMascot(Mascot mascot) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Mascot>> getMascot(Id? id) async {
    throw UnimplementedError();
  }
}
