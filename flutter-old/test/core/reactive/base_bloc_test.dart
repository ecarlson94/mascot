import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/reactive/base_bloc.dart';

class TestEvent {
  final String name;

  const TestEvent(this.name);
}

class TestEvent2 extends TestEvent {
  const TestEvent2(String name) : super(name);
}

class EffectTriggeredEvent extends TestEvent {
  const EffectTriggeredEvent(String name) : super(name);
}

class TestState extends Equatable {
  final int callCount;

  const TestState(this.callCount);

  @override
  List<Object?> get props => [callCount];
}

class EffectTriggeredState extends TestState {
  final String eventName;

  const EffectTriggeredState(super.callCount, this.eventName);

  @override
  List<Object?> get props => [callCount, eventName];
}

class TestEffect extends BlocEffect<TestEvent, TestEvent2, TestState> {
  EffectRepeatStrategy _repeatStrategy = EffectRepeatStrategy.every;

  TestEffect(this.name);

  @override
  EffectRepeatStrategy get repeatStrategy => _repeatStrategy;
  set repeatStrategy(EffectRepeatStrategy value) => _repeatStrategy = value;

  EffectReplaceStrategy _replacementStrategy = EffectReplaceStrategy.replace;
  @override
  EffectReplaceStrategy get replacementStrategy => _replacementStrategy;
  set replacementStrategy(EffectReplaceStrategy value) =>
      _replacementStrategy = value;

  final String name;

  @override
  Stream<TestEvent> call(
    TestEvent event,
    TestState state,
  ) async* {
    yield EffectTriggeredEvent('$name:${event.name}');
    await Future.delayed(const Duration(milliseconds: 100));
    yield EffectTriggeredEvent('$name:${event.name}');
  }
}

class TestBloc extends BaseBloc<TestEvent, TestState> {
  TestBloc() : super(const TestState(0));
}

void main() {
  group('BaseBloc', () {
    group('actions', () {
      blocTest(
        'should be called when targeted event is triggered',
        build: () => TestBloc()
          ..createAction(
            (TestEvent2 event, state) => TestState(state.callCount + 1),
          ),
        act: (bloc) => bloc.add(const TestEvent2('test')),
        expect: () => const <TestState>[TestState(1)],
      );

      blocTest(
        'should not be called when other event is triggered',
        build: () => TestBloc()
          ..createAction(
            (TestEvent2 event, state) => TestState(state.callCount + 1),
          )
          ..createAction(
            (TestEvent event, state) => state,
          ),
        act: (bloc) => bloc.add(const TestEvent('test')),
        expect: () => const <TestState>[TestState(0)],
      );
    });

    group('effects', () {
      late TestEffect effect;

      blocTest(
        'should add events from the stream returned by the effect',
        setUp: () {
          effect = TestEffect('first');
        },
        build: () => TestBloc()
          ..createEffect(effect)
          ..createAction(
            (EffectTriggeredEvent event, state) =>
                EffectTriggeredState(state.callCount + 1, event.name),
          ),
        act: (bloc) => bloc.add(const TestEvent2('test')),
        wait: const Duration(milliseconds: 200),
        expect: () => <TestState>[
          EffectTriggeredState(1, '${effect.name}:test'),
          EffectTriggeredState(2, '${effect.name}:test'),
        ],
      );

      blocTest(
        'should not add events from previous effects when the effect is replaced',
        setUp: () {
          effect = TestEffect('replacementEffect')
            ..repeatStrategy = EffectRepeatStrategy.every
            .._replacementStrategy = EffectReplaceStrategy.replace;
        },
        build: () => TestBloc()
          ..createEffect(effect)
          ..createAction(
            (EffectTriggeredEvent event, state) =>
                EffectTriggeredState(state.callCount + 1, event.name),
          ),
        act: (bloc) async => {
          bloc.add(const TestEvent2('test')),
          bloc.add(const TestEvent2('test2')),
        },
        wait: const Duration(milliseconds: 250),
        expect: () => <TestState>[
          EffectTriggeredState(1, '${effect.name}:test'),
          EffectTriggeredState(2, '${effect.name}:test2'),
          EffectTriggeredState(3, '${effect.name}:test2'),
        ],
      );

      blocTest(
        'should add events from all effects when the effect is not replaced',
        setUp: () {
          effect = TestEffect('additiveEffect')
            ..repeatStrategy = EffectRepeatStrategy.every
            .._replacementStrategy = EffectReplaceStrategy.add;
        },
        build: () => TestBloc()
          ..createEffect(effect)
          ..createAction(
            (EffectTriggeredEvent event, state) =>
                EffectTriggeredState(state.callCount + 1, event.name),
          ),
        act: (bloc) async => {
          bloc.add(const TestEvent2('test')),
          bloc.add(const TestEvent2('test2')),
        },
        wait: const Duration(milliseconds: 250),
        expect: () => <TestState>[
          EffectTriggeredState(1, '${effect.name}:test'),
          EffectTriggeredState(2, '${effect.name}:test2'),
          EffectTriggeredState(3, '${effect.name}:test'),
          EffectTriggeredState(4, '${effect.name}:test2'),
        ],
      );

      blocTest(
        'should run only once when repeatStrategy is once',
        setUp: () {
          effect = TestEffect('additiveEffect')
            ..repeatStrategy = EffectRepeatStrategy.once
            .._replacementStrategy = EffectReplaceStrategy.add;
        },
        build: () => TestBloc()
          ..createEffect(effect)
          ..createAction(
            (EffectTriggeredEvent event, state) =>
                EffectTriggeredState(state.callCount + 1, event.name),
          ),
        act: (bloc) async => {
          bloc.add(const TestEvent2('test')),
          bloc.add(const TestEvent2('test2')),
        },
        wait: const Duration(milliseconds: 250),
        expect: () => <TestState>[
          EffectTriggeredState(1, '${effect.name}:test'),
          EffectTriggeredState(2, '${effect.name}:test'),
        ],
      );
    });
  });
}
