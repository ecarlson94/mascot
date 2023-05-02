import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/clean_architecture/base_bloc.dart';
import '../../../../../core/data/stream_subscriber.dart';
import '../../../../expressions/domain/entities/expression.dart';
import '../../../domain/entities/mascot.dart';
import 'effects/mascot_updated_effect.dart';
import 'effects/stream_mascot_effect.dart';
import 'mascot_animator_actions.dart' as actions;

part 'mascot_animator_event.dart';
part 'mascot_animator_state.dart';

@injectable
class MascotAnimatorBloc
    extends BaseBloc<MascotAnimatorEvent, MascotAnimatorState>
    with SubscriptionDisposer
    implements StreamSubcriber {
  final StreamMascotEffect _streamMascotEffect;
  final MascotUpdatedEffect _mascotUpdatedEffect;

  MascotAnimatorBloc(
    this._streamMascotEffect,
    this._mascotUpdatedEffect,
  ) : super(MascotAnimatorInitial()) {
    createEffect(_streamMascotEffect);
    createAction(actions.loadingMascot);
    createAction(actions.streamMascotError);

    createEffect(_mascotUpdatedEffect);
    createAction(actions.setExpression);
  }
}
