import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/stream_subscriber.dart';
import '../../../../core/error/error.dart';
import '../../../../core/utils/constants.dart';
import '../../../expressions/domain/entities/expression.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/usecases/stream_mascot.dart';

part 'mascot_animator_event.dart';
part 'mascot_animator_state.dart';

@injectable
class MascotAnimatorBloc extends Bloc<MascotAnimatorEvent, MascotAnimatorState>
    with SubscriptionDisposer
    implements StreamSubcriber {
  final StreamMascot streamMascot;

  MascotAnimatorBloc(this.streamMascot)
      : super(MascotAnimatorInitial(
          none(),
          defaultExpressionName,
        )) {
    on<MascotAnimatorEvent>((event, emit) async {
      if (event is LoadMascot) {
        emit(MascotAnimatorLoading(
          state.expressionMapOption,
          state.expression,
        ));

        var failureOrMascotStream = await streamMascot(event.mascotId);
        failureOrMascotStream.fold(
          (l) => emit(
            MascotAnimatorError(
              ErrorCodes.loadMascotFailureCode,
              state.expressionMapOption,
              state.expression,
            ),
          ),
          (stream) => subscriptions.add(
            stream.listen(
              (value) => add(SetMascot(value)),
            ),
          ),
        );
      } else if (event is SetMascot) {
        var expressionMap = {for (var e in event.mascot.expressions) e.name: e};
        emit(MascotLoaded(some(expressionMap), state.expression));
      }
    });
  }
}
