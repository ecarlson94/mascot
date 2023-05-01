import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/stream_subscriber.dart';

// Implementations must be pure functions, meaning that they
// should always return the same output given the same input
// and should not have any side effects.
typedef BlocAction<TEvent, TState> = TState Function(
  TEvent event,
  TState state,
);

// Effects are similar to actions, but they can have side effects.
// They are useful for making API calls, navigating, logging, etc.
abstract class BlocEffect<TBaseEvent, TEvent extends TBaseEvent, TState> {
  Stream<TBaseEvent> call(TEvent event, TState state);
}

abstract class BaseBloc<TEvent, TState> extends Bloc<TEvent, TState>
    with SubscriptionDisposer
    implements StreamSubcriber {
  BaseBloc(super.initialState);

  void createAction<AEvent extends TEvent>(BlocAction<AEvent, TState> action) {
    on<AEvent>((event, emit) => emit(action(event, state)));
  }

  void createEffect<AEvent extends TEvent>(
    BlocEffect<TEvent, AEvent, TState> effect,
  ) {
    on<AEvent>((event, emit) {
      var sub = effect(event, state).listen(
        (event) {
          add(event);
        },
      );

      subscriptions.add(sub);
    });
  }
}
