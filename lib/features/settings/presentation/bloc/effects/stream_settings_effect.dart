import 'package:injectable/injectable.dart';

import '../../../../../core/clean_architecture/usecase.dart';
import '../../../../../core/reactive/base_bloc.dart';
import '../../../domain/usecases/stream_settings.dart';
import '../settings_bloc.dart';

@injectable
class StreamSettingsEffect
    extends BlocEffect<SettingsEvent, LoadSettingsEvent, SettingsState> {
  final StreamSettings _streamSettings;

  StreamSettingsEffect(this._streamSettings);

  @override
  Stream<SettingsEvent> call(
    LoadSettingsEvent event,
    SettingsState state,
  ) async* {
    yield const LoadingSettingsEvent();

    var settingsStreamOrFailure = await _streamSettings(NoParams());
    yield* settingsStreamOrFailure.fold(
      (failure) async* {
        yield LoadSettingsFailureEvent(failure);
      },
      (settingsStream) =>
          settingsStream.map((settings) => SettingsUpdatedEvent(settings)),
    );
  }
}
