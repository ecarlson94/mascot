import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/exception.dart';
import 'package:mascot/features/microphone/device/services/microphone_context_impl.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MicrophoneContextImpl classUnderTest;

  setUp(() {
    context = TestContext();
    classUnderTest = MicrophoneContextImpl(
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
          const firstVolume = DecibelLufs(0.0);
          var stream = Single.value(firstVolume);
          when(context.mocks.microphone.hasPermission())
              .thenAnswer((_) => Single.value(true));
          when(context.mocks.microphone.volumeStream).thenAnswer((_) => stream);

          // act
          final result = await classUnderTest.getVolumeStream().single;

          // assert
          expect(result, firstVolume);
          verify(context.mocks.microphone.hasPermission());
          verify(context.mocks.microphone.volumeStream);
        },
      );

      test(
        'should emit no microphone permission failure when no permission',
        () async {
          // arrange
          when(context.mocks.microphone.hasPermission())
              .thenAnswer((_) => Single.value(false));

          // act
          final result = classUnderTest.getVolumeStream();

          // assert
          await expectLater(
              result, emitsError(isA<MicrophonePermissionException>()));
          verify(context.mocks.microphone.hasPermission());
          verifyNever(context.mocks.microphone.volumeStream);
        },
      );
    });
  });
}
