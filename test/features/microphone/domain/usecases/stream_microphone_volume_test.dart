import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/usecase.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/microphone/domain/usecases/stream_microphone_volume.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../fixtures/mocks.mocks.dart';

void main() {
  late StreamMicrophoneVolume usecase;
  late MockMicrophoneContext mockMicrophoneContext;

  setUp(() {
    mockMicrophoneContext = MockMicrophoneContext();
    usecase = StreamMicrophoneVolume(mockMicrophoneContext);
  });

  group('StreamMicrophoneVolume', () {
    test('should return a stream of microphone volume', () async {
      // arrange
      const firstVolume = DecibelLufs(0.0);
      var stream = Single.value(firstVolume);
      when(mockMicrophoneContext.getVolumeStream()).thenAnswer((_) => stream);

      // act
      final result = await usecase(NoParams()).single;

      // assert
      expect(result, firstVolume);
      verify(mockMicrophoneContext.getVolumeStream());
    });
  });
}
