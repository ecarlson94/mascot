import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/clean_architecture/usecase.dart';
import '../../../../core/data/stream_subscriber.dart';
import '../../../../core/error/error.dart';
import '../../../microphone/domain/models/decibel_lufs.dart';
import '../../domain/entities/settings.dart';
import '../../domain/usecases/stream_settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState>
    with SubscriptionDisposer
    implements StreamSubcriber {
  final StreamSettings streamSettings;

  SettingsBloc(this.streamSettings) : super(SettingsInitial(none(), none())) {
    on<SettingsEvent>((event, emit) async {
      if (event is LoadSettings) {
        var failureOrSettingsStream = await streamSettings(NoParams());
        failureOrSettingsStream.fold(
          (l) => emit(
            SettingsError(ErrorCodes.loadSettingsFailureCode, none(), none()),
          ),
          (settingsStream) => emit(
            SettingsLoaded(
              _settingValueStreamOption(
                settingsStream,
                (state) => state.favoriteMascotIdStreamOption,
                (settings) => settings.favoriteMascotId,
              ),
              _settingValueStreamOption(
                settingsStream,
                (state) => state.talkingThresholdStreamOption,
                (settings) => settings.talkingThreshold,
              ),
            ),
          ),
        );
      }
    });
  }

  Option<BehaviorSubject<T>> _settingValueStreamOption<T>(
    Stream<Settings> settingsStream,
    Option<BehaviorSubject<T>> Function(SettingsState state) currentValueStream,
    T Function(Settings settings) valueSelector, {
    bool alwaysEmit = false,
  }) {
    var valueStream = currentValueStream(state).getOrElse(
      () => BehaviorSubject<T>(),
    );

    var sub = settingsStream.listen((settings) {
      var oldValue = valueStream.hasValue ? valueStream.value : null;
      var newValue = valueSelector(settings);
      if (alwaysEmit || oldValue != newValue) {
        valueStream.add(newValue);
      }
    });

    subscriptions.add(sub);

    return some(valueStream);
  }
}
