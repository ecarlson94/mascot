import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/actions/presentation/bloc/actions_overlay_bloc.dart';

void main() {
  late ActionsOverlayBloc bloc;

  setUp(() {
    bloc = ActionsOverlayBloc();
  });

  test('initialState should be ActionsOverlayInitial', () {
    // assert
    expect(bloc.state, const ActionsOverlayInitial());
  });

  group('ToggleShowActions', () {
    blocTest<ActionsOverlayBloc, ActionsOverlayState>(
      'should emit [ActionsOverlayChanged] state with showActions set to true',
      build: () => bloc,
      seed: () => const ActionsOverlayState(false),
      act: (bloc) => bloc.add(ToggleShowActionsEvent()),
      expect: () => [
        isA<ActionsOverlayState>()
            .having((state) => state.showActions, 'showActions', true),
      ],
    );

    blocTest<ActionsOverlayBloc, ActionsOverlayState>(
      'should emit [ActionsOverlayChanged] state with showActions set to false',
      build: () => bloc,
      act: (bloc) => bloc.add(ToggleShowActionsEvent()),
      expect: () => [
        isA<ActionsOverlayState>()
            .having((state) => state.showActions, 'showActions', false),
      ],
    );
  });
}
