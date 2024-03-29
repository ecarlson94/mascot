import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/usecase.dart';
import 'package:mascot/features/settings/domain/usecases/stream_settings.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late StreamSettings usecase;

  setUp(() {
    context = TestContext();
    usecase = StreamSettings(context.mocks.settingsRepository);
  });

  test('StreamSettings usecase should stream the settings from the repository',
      () async {
    // arrange
    when(context.mocks.settingsRepository.streamSettings())
        .thenAnswer((_) => Single.value(context.data.settings));

    // act
    final result = await usecase(NoParams()).single;

    // assert
    expect(
      result,
      context.data.settings,
    );
    verify(context.mocks.settingsRepository.streamSettings());
    verifyNoMoreInteractions(context.mocks.settingsRepository);
  });
}
