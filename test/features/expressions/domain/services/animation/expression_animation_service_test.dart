import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/expressions/domain/services/animation/expression_animation_service.dart';
import 'package:mascot/features/expressions/domain/services/animation/expression_trigger_factory.dart';
import 'package:mascot/features/microphone/domain/models/decibel_lufs.dart';
import 'package:mascot/features/settings/domain/entities/settings.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late ExpressionAnimationService expressionAnimationService;
  late Set<Expression> expressions;
  late BehaviorSubject<Settings> settingsStream;
  late Stream<DecibelLufs> microphoneVolumeStream;

  setUp(() {
    context = TestContext();
    settingsStream = BehaviorSubject.seeded(context.data.settings);
    microphoneVolumeStream = Stream.value(const DecibelLufs(-11));

    expressionAnimationService = ExpressionAnimationServiceImpl(
      ExpressionTriggerFactory(
        context.mocks.settingsRepository,
        context.mocks.streamMicrophoneVolume,
      ),
    );

    expressions = context.data.expressions.toSet();
    expressions.add(
      Expression(
        id: 3,
        name: 'testName',
        description: '3rd desc',
        image: Uint8List(5),
        priority: 990,
        activator: ExpressionTriggers.always,
      ),
    );

    when(context.mocks.settingsRepository.streamSettings())
        .thenAnswer((_) async => Right(settingsStream));
    when(context.mocks.streamMicrophoneVolume(any))
        .thenAnswer((_) async => Right(microphoneVolumeStream));
  });

  group('ExpressionAnimationService', () {
    test(
      'should return a stream of expressions',
      () {
        // arrange
        var result = expressionAnimationService.animateExpressions(expressions);

        // assert
        expect(result, isA<Stream<Expression>>());
      },
    );

    test(
      'should return a stream of expressions with the highest priority (lower number) first',
      () async {
        // arrange
        var result = expressionAnimationService.animateExpressions(expressions);

        // act
        var expression = await result.skip(1).first;

        // assert
        expect(expression.priority, 990);
      },
    );

    test(
      'should return new expression when trigger is triggered',
      () async {
        // arrange
        microphoneVolumeStream = Stream.fromIterable([
          const DecibelLufs(-11),
          const DecibelLufs(-10),
        ]);

        // act
        var result = expressionAnimationService.animateExpressions(expressions);

        // assert
        expect(
          await result.skip(2).first,
          expressions.firstWhere(
            (e) => e.activator == ExpressionTriggers.talking,
          ),
        );
      },
    );

    test(
      'should return new expression when trigger is de-triggered',
      () async {
        // arrange
        microphoneVolumeStream = Stream.fromIterable([
          const DecibelLufs(-11),
          const DecibelLufs(-10),
          const DecibelLufs(-23),
        ]);

        // act
        var result = expressionAnimationService.animateExpressions(expressions);

        // assert
        expect(
          await result.skip(3).first,
          expressions.firstWhere(
            (e) => e.priority == 990,
          ),
        );
      },
    );
  });
}
