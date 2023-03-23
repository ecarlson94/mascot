import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/error/error.dart';
import '../../../../core/error/failure.dart';
import '../../domain/models/decibel_lufs.dart';
import '../../domain/usecases/stream_microphone_volume.dart';

part 'microphone_volume_event.dart';
part 'microphone_volume_state.dart';

@injectable
class MicrophoneVolumeBloc
    extends Bloc<MicrophoneVolumeEvent, MicrophoneVolumeState> {
  final StreamMicrophoneVolume _streamMicrophoneVolume;

  MicrophoneVolumeBloc(this._streamMicrophoneVolume)
      : super(
          MicrophoneVolumeInitial(none()),
        ) {
    on<MicrophoneVolumeEvent>(
      (event, emit) async {
        if (event is InitializeMicrophoneVolume) {
          emit(MicrophoneVolumeLoading(state.volumeStreamOption));
          var volumeStreamOrFailure = await _streamMicrophoneVolume(NoParams());
          volumeStreamOrFailure.fold(
            (l) => emit(
              MicrophoneVolumeError(
                _mapMicFailureToErrorCode(l),
                none(),
              ),
            ),
            (r) => emit(MicrophoneVolumeLoaded(some(r))),
          );
        }
      },
    );
  }

  int _mapMicFailureToErrorCode(Failure failure) {
    if (failure is NoMicrophonePermissionFailure) {
      return ErrorCodes.noMicrophonePermissionFailueCode;
    }
    if (failure is MicrophoneFailure) return ErrorCodes.microphoneFailureCode;
    return ErrorCodes.unknownFailureCode;
  }
}
