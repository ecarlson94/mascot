import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// Implementations must be pure functions, meaning that they
// should always return the same output given the same input
// and should not have any side effects.
typedef BlocAction<TEvent, TState> = TState Function(
  TEvent event,
  TState state,
);

// Effects are similar to actions, but they can have side effects.
// They are useful for making API calls, navigating, logging, etc.
// BEWARE: Infinite loops can be easily created with effects.
// Avoid returning the same event that triggered the effect.
abstract class BlocEffect<TBaseEvent, TCaptureEvent extends TBaseEvent,
    TState> {
  Stream<TBaseEvent> call(TCaptureEvent event, TState state);

  EffectRepeatStrategy get repeatStrategy => EffectRepeatStrategy.every;

  EffectReplaceStrategy get replacementStrategy =>
      EffectReplaceStrategy.replace;
}

enum EffectRepeatStrategy {
  // The effect will be called only once.
  once,
  // The effect will be called every time the event is dispatched.
  every,
}

enum EffectReplaceStrategy {
  // The effect will be replaced by the new one.
  replace,
  // The effect will be added to the existing one.
  add,
}

abstract class BaseBloc<TEvent, TState> extends Bloc<TEvent, TState>
    implements Disposable {
  final Map<String, List<StreamSubscription>> _effectSubscriptions = {};

  BaseBloc(super.initialState);

  void createAction<AEvent extends TEvent>(BlocAction<AEvent, TState> action) {
    on<AEvent>((event, emit) => emit(action(event, state)));
  }

  void createEffect<AEvent extends TEvent>(
    BlocEffect<TEvent, AEvent, TState> effect,
  ) {
    var effectType = effect.runtimeType.toString();
    _effectSubscriptions[effectType] = List.empty(growable: true);

    on<AEvent>((event, emit) async {
      var effectSubs = _effectSubscriptions[effectType]!;
      if (effect.repeatStrategy == EffectRepeatStrategy.once &&
          effectSubs.isNotEmpty) {
        return;
      }

      if (effect.replacementStrategy == EffectReplaceStrategy.replace) {
        for (var sub in effectSubs) {
          await sub.cancel();
        }

        effectSubs.clear();
      }

      var sub = effect(event, state).listen(
        (event) {
          add(event);
        },
      );

      _effectSubscriptions[effectType]!.add(sub);
    });
  }

  @override
  Future<void> onDispose() {
    for (var effect in _effectSubscriptions.keys) {
      for (var sub in _effectSubscriptions[effect]!) {
        sub.cancel();
      }
    }

    _effectSubscriptions.clear();

    return close();
  }
}
