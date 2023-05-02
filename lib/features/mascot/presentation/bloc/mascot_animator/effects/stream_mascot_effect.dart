import 'package:injectable/injectable.dart';

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
  ) async* {
    yield const LoadingMascotEvent();

    var failureOrMascotStream = await streamMascot(event.mascotId);
    yield* failureOrMascotStream.fold(
      (l) async* {
        yield const StreamMascotErrorEvent();
      },
      (mascotStream) =>
          mascotStream.map((mascot) => MascotUpdatedEvent(mascot)),
    );
  }
}
