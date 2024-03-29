import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator/effects/stream_mascot_effect.dart';
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator/mascot_animator_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late StreamMascotEffect effect;

  setUp(() {
    context = TestContext();
    effect = StreamMascotEffect(context.mocks.streamMascot);

    when(context.mocks.streamMascot(any)).thenAnswer(
      (_) => Single.value(context.data.mascot),
    );
  });

  group('MascotAnimatorBloc StreamMascotEffect', () {
    test('should return [LoadingMascot, MascotUpdated] when mascot is loaded',
        () async {
      // arrange
      final event = LoadMascotEvent(context.data.mascot.id);
      final state = MascotAnimatorInitial();

      // act
      final result = effect(event, state);
      var events = await result.take(2).toList();

      // assert
      expect(
        events,
        [
          const LoadingMascotEvent(),
          MascotUpdatedEvent(context.data.mascot),
        ],
      );
    });
  });
}
