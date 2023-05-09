import 'package:injectable/injectable.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../../../core/reactive/base_bloc.dart';
import '../../../../domain/usecases/stream_mascot.dart';
import '../mascot_animator_bloc.dart';

@injectable
class StreamMascotEffect extends BlocEffect<MascotAnimatorEvent,
    LoadMascotEvent, MascotAnimatorState> {
  final StreamMascot streamMascot;

  StreamMascotEffect(this.streamMascot);

  @override
  Stream<MascotAnimatorEvent> call(
    LoadMascotEvent event,
    MascotAnimatorState state,
  ) =>
      streamMascot(event.mascotId)
          .map<MascotAnimatorEvent>((mascot) => MascotUpdatedEvent(mascot))
          .startWith(const LoadingMascotEvent())
          .onErrorReturn(const StreamMascotErrorEvent());
}
