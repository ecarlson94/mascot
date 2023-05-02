import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator/effects/mascot_updated_effect.dart';
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator/effects/stream_mascot_effect.dart';
import 'package:mascot/features/mascot/presentation/bloc/mascot_animator/mascot_animator_bloc.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  group('MascotAnimatorBloc', () {
    late TestContext context;
    late MascotAnimatorBloc bloc;

    setUp(() {
      context = TestContext();
      bloc = MascotAnimatorBloc(
        StreamMascotEffect(context.mocks.streamMascot),
        MascotUpdatedEffect(context.mocks.expressionAnimationService),
      );
    });

    test('initial state is MascotInitial', () {
      // assert
      expect(bloc.state, MascotAnimatorInitial(none()));
    });
  });
}
