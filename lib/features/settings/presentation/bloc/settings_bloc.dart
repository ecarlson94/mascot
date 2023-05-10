import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/reactive/base_bloc.dart';
import '../../../microphone/domain/models/decibel_lufs.dart';
import '../../domain/entities/settings.dart';
import 'effects/set_talking_threshold_effect.dart';
import 'effects/stream_settings_effect.dart';
import 'settings_actions.dart' as actions;

part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends BaseBloc<SettingsEvent, SettingsState> {
  final StreamSettingsEffect _streamSettingsEffect;
  final SetTalkingThresholdEffect _setTalkingThreshold;

  SettingsBloc(
    this._streamSettingsEffect,
    this._setTalkingThreshold,
  ) : super(SettingsInitial()) {
    createEffect(_streamSettingsEffect);
    createAction(actions.loadSettingsFailure);
    createAction(actions.settingsUpdated);

    createEffect(_setTalkingThreshold);
  }
}
