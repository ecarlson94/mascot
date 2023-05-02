import 'package:injectable/injectable.dart';

import '../../../../../../core/clean_architecture/usecase.dart';
import '../../../../../../core/reactive/base_bloc.dart';
import '../../../../domain/usecases/stream_microphone_volume.dart';
import '../microphone_volume_bloc.dart';

@injectable
class StreamVolumeEffect extends BlocEffect<MicrophoneVolumeEvent,
    InitializeMicrophoneVolumeEvent, MicrophoneVolumeState> {
  final StreamMicrophoneVolume _streamMicrophoneVolume;

  StreamVolumeEffect(this._streamMicrophoneVolume);

  @override
  Stream<MicrophoneVolumeEvent> call(
    InitializeMicrophoneVolumeEvent event,
    MicrophoneVolumeState state,
  ) async* {
    yield const LoadingVolumeStreamEvent();

    var volumeStreamOrFailure = await _streamMicrophoneVolume(NoParams());
    yield* volumeStreamOrFailure.fold(
      (failure) async* {
        yield StreamVolumeFailureEvent(failure);
      },
      (volumeStream) =>
          volumeStream.map((volume) => MicrophoneVolumeUpdatedEvent(volume)),
    );
  }
}
