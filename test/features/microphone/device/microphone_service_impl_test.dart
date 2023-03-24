import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/microphone/device/services/microphone_service_impl.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/option.dart';
import '../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MicrophoneServiceImpl classUnderTest;

  setUp(() {
    context = TestContext();
    classUnderTest = MicrophoneServiceImpl(
      context.mocks.microphone,
      context.mocks.getLogger(),
    );
  });

  group('MicrophoneServiceImpl', () {
    group('getVolumeStream', () {
      test(
        'should return a stream of microphone volume',
        () async {
          // arrange
          const stream = Stream<DecibelLufs>.empty();
          when(context.mocks.microphone.hasPermission())
              .thenAnswer((_) async => true);
          when(context.mocks.microphone.volumeStream).thenAnswer((_) => stream);

          // act
          final result = await classUnderTest.getVolumeStream();

          // assert
          expect(result.getOrFailTest(), stream);
          verify(context.mocks.microphone.hasPermission());
          verify(context.mocks.microphone.volumeStream);
        },
      );

      test(
        'should return no microphone permission failure when no permission',
        () async {
          // arrange
          when(context.mocks.microphone.hasPermission())
              .thenAnswer((_) async => false);

          // act
          final result = await classUnderTest.getVolumeStream();

          // assert
          expect(result, Left(NoMicrophonePermissionFailure()));
          verify(context.mocks.microphone.hasPermission());
          verifyNever(context.mocks.microphone.volumeStream);
        },
      );

      test(
        'should return microphone failure when exception',
        () async {
          // arrange
          when(context.mocks.microphone.hasPermission())
              .thenAnswer((_) async => true);
          when(context.mocks.microphone.volumeStream)
              .thenThrow(Exception('test'));

          // act
          final result = await classUnderTest.getVolumeStream();

          // assert
          expect(result, Left(MicrophoneFailure()));
          verify(context.mocks.microphone.hasPermission());
          verify(context.mocks.microphone.volumeStream);
        },
      );
    });
  });
}
