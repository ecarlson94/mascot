import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/reactive/base_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../domain/models/decibel_lufs.dart';
import 'effects/stream_volume_effect.dart';
import 'microphone_volume_actions.dart' as actions;

part 'microphone_volume_event.dart';
part 'microphone_volume_state.dart';

@injectable
class MicrophoneVolumeBloc
    extends BaseBloc<MicrophoneVolumeEvent, MicrophoneVolumeState> {
  final StreamVolumeEffect _streamVolumeEffect;

  MicrophoneVolumeBloc(this._streamVolumeEffect)
      : super(MicrophoneVolumeInitial(none())) {
    createEffect(_streamVolumeEffect);
    createAction(actions.loadingVolumeStream);
    createAction(actions.microphoneVolumeUpdated);
    createAction(actions.streamVolumeFailure);
  }
}
