import 'package:injectable/injectable.dart';

import '../../../../../core/reactive/base_bloc.dart';
import '../../../domain/usecases/save_talking_threshold.dart';
import '../settings_bloc.dart';

@injectable
class SetTalkingThresholdEffect
    extends BlocEffect<SettingsEvent, SetTalkingThresholdEvent, SettingsState> {
  final SaveTalkingThreshold _saveTalkingThreshold;

  SetTalkingThresholdEffect(this._saveTalkingThreshold);

  @override
  Stream<SettingsEvent> call(
    SetTalkingThresholdEvent event,
    SettingsState state,
  ) async* {
    await _saveTalkingThreshold(event.talkingThreshold);
  }
}
