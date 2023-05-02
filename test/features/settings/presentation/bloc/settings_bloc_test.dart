import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/settings/presentation/bloc/effects/set_talking_threshold_effect.dart';
import 'package:mascot/features/settings/presentation/bloc/effects/stream_settings_effect.dart';
import 'package:mascot/features/settings/presentation/bloc/settings_bloc.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  group('SettingsBloc', () {
    late TestContext context;
    late SettingsBloc bloc;

    setUp(() {
      context = TestContext();
      bloc = SettingsBloc(
        StreamSettingsEffect(context.mocks.streamSettings),
        SetTalkingThresholdEffect(context.mocks.saveTalkingThreshold),
      );
    });

    test('initialState should be SettingsInitial', () {
      // assert
      expect(bloc.state, SettingsInitial());
    });
  });
}
