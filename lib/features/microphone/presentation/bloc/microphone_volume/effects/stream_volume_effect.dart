import 'package:injectable/injectable.dart';

import '../../../../../../core/reactive/base_bloc.dart';
import '../../../../../../core/clean_architecture/usecase.dart';
import '../../../../domain/usecases/stream_microphone_volume.dart';
import '../microphone_volume_bloc.dart';

@injectable
class StreamVolumeEffect extends BlocEffect<MicrophoneVolumeEvent,
    InitializeMicrophoneVolume, MicrophoneVolumeState> {
  final StreamMicrophoneVolume _streamMicrophoneVolume;

  StreamVolumeEffect(this._streamMicrophoneVolume);

  @override
  Stream<MicrophoneVolumeEvent> call(
    InitializeMicrophoneVolume event,
    MicrophoneVolumeState state,
  ) async* {
    yield const LoadingVolumeStream();

    var volumeStreamOrFailure = await _streamMicrophoneVolume(NoParams());
    yield* volumeStreamOrFailure.fold(
      (failure) async* {
        yield StreamVolumeFailure(failure);
      },
      (volumeStream) =>
          volumeStream.map((volume) => MicrophoneVolumeUpdated(volume)),
    );
  }
}
