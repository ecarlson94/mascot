import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot/create_mascot_actions.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot/create_mascot_bloc.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot/effects/save_mascot_effect.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  group('CreateMascotBloc', () {
    late TestContext context;
    late CreateMascotBloc bloc;

    setUp(() {
      context = TestContext();
      bloc = CreateMascotBloc(
        SaveMascotEffect(context.mocks.addMascot),
      );
    });

    test('initialState should be CreateMascotInitial', () {
      // assert
      expect(bloc.state, initialCreateMascotState);
    });
  });
}
