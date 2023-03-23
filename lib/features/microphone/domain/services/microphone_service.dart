import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../models/decibel_lufs.dart';

typedef VolumeStreamOrFailureFuture
    = Future<Either<Failure, Stream<DecibelLufs>>>;

abstract class MicrophoneService {
  VolumeStreamOrFailureFuture getVolumeStream();
}
