import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/usecase.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/microphone/domain/usecases/stream_microphone_volume.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/mocks.mocks.dart';

void main() {
  late StreamMicrophoneVolume usecase;
  late MockMicrophoneService mockMicrophoneService;

  setUp(() {
    mockMicrophoneService = MockMicrophoneService();
    usecase = StreamMicrophoneVolume(mockMicrophoneService);
  });

  group('StreamMicrophoneVolume', () {
    test('should return a stream of microphone volume', () async {
      // arrange
      const stream = Stream<DecibelLufs>.empty();
      when(mockMicrophoneService.getVolumeStream())
          .thenAnswer((_) async => const Right(stream));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, const Right(stream));
      verify(mockMicrophoneService.getVolumeStream());
    });
  });
}
