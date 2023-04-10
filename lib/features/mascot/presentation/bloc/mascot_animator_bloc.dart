import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/stream_subscriber.dart';
import '../../../../core/error/error.dart';
import '../../../expressions/domain/entities/expression.dart';
import '../../../expressions/domain/services/animation/expression_animation_service.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/usecases/stream_mascot.dart';

part 'mascot_animator_event.dart';
part 'mascot_animator_state.dart';

@injectable
class MascotAnimatorBloc extends Bloc<MascotAnimatorEvent, MascotAnimatorState>
    with SubscriptionDisposer
    implements StreamSubcriber {
  final StreamMascot streamMascot;
  final ExpressionAnimationService expressionAnimationService;

  MascotAnimatorBloc(
    this.streamMascot,
    this.expressionAnimationService,
  ) : super(
          MascotAnimatorInitial(none()),
        ) {
    on<LoadMascot>(
      (event, emit) async {
        emit(MascotAnimatorLoading(state.expressionOption));

        var failureOrMascotStream = await streamMascot(event.mascotId);
        failureOrMascotStream.fold(
          (l) => emit(
            MascotAnimatorError(
              ErrorCodes.loadMascotFailureCode,
              state.expressionOption,
            ),
          ),
          (stream) => subscriptions.add(
            stream.listen(
              (mascot) {
                if (isClosed) return;
                add(SetMascot(mascot));
              },
            ),
          ),
        );
      },
    );

    on<SetMascot>(
      (event, emit) async {
        for (var sub
            in subscriptions.whereType<StreamSubscription<Expression>>()) {
          await sub.cancel();
        }

        var animationStream = await expressionAnimationService
            .animateExpressions(event.mascot.expressions);
        var animationSub = animationStream.listen((event) {
          add(SetExpression(event));
        });

        subscriptions.add(animationSub);
      },
    );

    on<SetExpression>(
      (event, emit) async {
        emit(ExpressionChanged(some(event.expression)));
      },
    );
  }

  @override
  Future<void> close() {
    onDispose();
    return super.close();
  }
}
