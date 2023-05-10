import 'package:injectable/injectable.dart';
import 'package:mascot/core/error/error.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

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
  ) =>
      _streamSettings(NoParams())
          .map<SettingsEvent>((settings) => SettingsUpdatedEvent(settings))
          .startWith(const LoadingSettingsEvent())
          .onErrorReturn(
            const LoadSettingsFailureEvent(ErrorCodes.loadSettingsFailure),
          );
}
