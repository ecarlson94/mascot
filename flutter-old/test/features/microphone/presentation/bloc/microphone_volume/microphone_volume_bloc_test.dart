import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume/effects/stream_volume_effect.dart';
import 'package:mascot/features/microphone/presentation/bloc/microphone_volume/microphone_volume_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MicrophoneVolumeBloc bloc;
  late Stream<DecibelLufs> volumeStream;

  setUp(() {
    context = TestContext();
    bloc = MicrophoneVolumeBloc(
      StreamVolumeEffect(context.mocks.streamMicrophoneVolume),
    );

    volumeStream = const Stream<DecibelLufs>.empty();
    when(context.mocks.streamMicrophoneVolume(any))
        .thenAnswer((_) => volumeStream);
  });

  group('MicrophoneVolumeBloc', () {
    test('Initial state should be MicrophoneVolumeInitial', () {
      // asser
      expect(bloc.state, MicrophoneVolumeInitial());
    });
  });
}
