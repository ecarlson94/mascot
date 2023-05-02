import 'package:dartz/dartz.dart';
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
        .thenAnswer((_) async => Right(volumeStream));
  });

  group('MicrophoneVolumeBloc', () {
    test('Initial state should be MicrophoneVolumeInitial', () {
      // asser
      expect(bloc.state, MicrophoneVolumeInitial(none()));
    });

    // group('InitializeMicrophoneVolume', () {
    //   blocTest(
    //     'should emit [MicrophoneVolumeLoading, MicrophoneVolumeLoaded] when initialization is successful',
    //     build: () => bloc,
    //     act: (bloc) => bloc.add(InitializeMicrophoneVolume()),
    //     expect: () => [
    //       MicrophoneVolumeLoading(none()),
    //       MicrophoneVolumeLoaded(some(volumeStream)),
    //     ],
    //   );

    //   blocTest(
    //     'should use the stream microphone volume usecase',
    //     build: () => bloc,
    //     act: (bloc) => bloc.add(InitializeMicrophoneVolume()),
    //     verify: (bloc) => verify(context.mocks.streamMicrophoneVolume(any)),
    //   );

    //   blocTest(
    //     'should emit [MicrophoneVolumeLoading, MicrophoneVolumeError(${ErrorCodes.noMicrophonePermissionFailureCode})] when no microphone permission is granted',
    //     build: () => bloc,
    //     setUp: () {
    //       when(context.mocks.streamMicrophoneVolume(any))
    //           .thenAnswer((_) async => Left(NoMicrophonePermissionFailure()));
    //     },
    //     act: (bloc) => bloc.add(InitializeMicrophoneVolume()),
    //     expect: () => [
    //       MicrophoneVolumeLoading(none()),
    //       MicrophoneVolumeError(
    //         ErrorCodes.noMicrophonePermissionFailureCode,
    //         none(),
    //       ),
    //     ],
    //   );

    //   blocTest(
    //     'should emit [MicrophoneVolumeLoading, MicrophoneVolumeError(${ErrorCodes.microphoneFailureCode})] when initialization fails',
    //     build: () => bloc,
    //     setUp: () {
    //       when(context.mocks.streamMicrophoneVolume(any))
    //           .thenAnswer((_) async => Left(NoMicrophonePermissionFailure()));
    //     },
    //     act: (bloc) => bloc.add(InitializeMicrophoneVolume()),
    //     expect: () => [
    //       MicrophoneVolumeLoading(none()),
    //       MicrophoneVolumeError(
    //         ErrorCodes.microphoneFailureCode,
    //         none(),
    //       ),
    //     ],
    //   );

    //   blocTest(
    //     'should emit [MicrophoneVolumeLoading, MicrophoneVolumeError(${ErrorCodes.unknownFailureCode})] when failure is unknown',
    //     build: () => bloc,
    //     setUp: () {
    //       when(context.mocks.streamMicrophoneVolume(any))
    //           .thenAnswer((_) async => Left(LocalDataSourceFailure()));
    //     },
    //     act: (bloc) => bloc.add(InitializeMicrophoneVolume()),
    //     expect: () => [
    //       MicrophoneVolumeLoading(none()),
    //       MicrophoneVolumeError(
    //         ErrorCodes.unknownFailureCode,
    //         none(),
    //       ),
    //     ],
    //   );
    // });
  });
}
