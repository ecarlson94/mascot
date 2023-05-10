import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/exception.dart';
import 'package:mascot/features/expressions/data/models/expression_model.dart';
import 'package:mascot/features/mascot/data/models/mascot_model.dart';
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MascotsRepositoryImpl repository;

  MascotModel getMascotModel() =>
      context.data.mascotMapper.fromMascot(context.data.mascot);

  setUp(() {
    context = TestContext();
    repository = MascotsRepositoryImpl(
      context.mocks.mascotsLocalDataSource,
      context.mocks.expressionsLocalDataSource,
      context.data.mascotMapper,
      context.mocks.getLogger(),
    );

    var mascotModel = getMascotModel();
    mascotModel = mascotModel.copyWith(
      expressions: mascotModel.expressions
          .map((e) => ExpressionModel.empty().copyWith(id: e.id))
          .toList(),
    );

    when(context.mocks.mascotsLocalDataSource.getObject(any))
        .thenAnswer((_) => Single.value(mascotModel));
    when(context.mocks.expressionsLocalDataSource.getObjects(any))
        .thenAnswer((_) => Single.value(getMascotModel().expressions));
  });

  group('MascotsRepositoryImpl', () {
    group('getMascot', () {
      test(
        'should return the requested mascot when call to local data source is successful',
        () async {
          // act
          final result =
              await repository.getMascot(context.data.mascot.id).single;

          // assert
          expect(
            result,
            context.data.mascotMapper.toMascot(getMascotModel()),
          );

          verify(context.mocks.mascotsLocalDataSource
              .getObject(context.data.mascot.id));
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );

      test('should fetch the expressions from the local data source', () async {
        // arrange
        var mascotModel = getMascotModel();
        when(context.mocks.mascotsLocalDataSource.getObject(any)).thenAnswer(
          (_) => Single.value(
            mascotModel.copyWith(
              expressions: mascotModel.expressions
                  .map((e) => ExpressionModel.empty().copyWith(id: e.id))
                  .toList(),
            ),
          ),
        );

        // act
        await repository.getMascot(context.data.mascot.id).single;

        // assert
        verify(context.mocks.expressionsLocalDataSource
            .getObjects(mascotModel.expressions.map((e) => e.id).toList()));
        verifyNoMoreInteractions(context.mocks.expressionsLocalDataSource);
      });

      test(
        'should populate the expressions on the Mascot object when invoking getMascot',
        () async {
          // act
          final result =
              await repository.getMascot(context.data.mascot.id).single;

          // assert
          expect(result.expressions, context.data.mascot.expressions);

          verify(context.mocks.mascotsLocalDataSource
              .getObject(context.data.mascot.id));
          verify(context.mocks.expressionsLocalDataSource.getObjects(
              context.data.mascot.expressions.map((e) => e.id).toList()));
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
          verifyNoMoreInteractions(context.mocks.expressionsLocalDataSource);
        },
      );
    });

    group('saveMascot', () {
      setUp(() async {
        when(context.mocks.mascotsLocalDataSource.putObject(any))
            .thenAnswer((_) => Single.value(context.data.mascot.id));
      });

      test(
        'should return the id of the added mascot when call to local data source is successful',
        () async {
          // act
          final result =
              await repository.saveMascot(context.data.mascot).single;

          // assert
          expect(result, context.data.mascot.id);

          verify(
            context.mocks.mascotsLocalDataSource.putObject(
              getMascotModel(),
            ),
          );
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );

      test(
        'should throw ArgementException when mascot has expressions without ids',
        () async {
          // arrange
          final mascot = context.data.mascot.copyWith(
            expressions: {
              context.data.expression.copyWith(id: 0),
              context.data.expression,
            },
          );

          // assert
          expect(
            repository.saveMascot(mascot),
            emitsError(isA<ArgumentException>()),
          );
        },
      );
    });

    group('streamMascot', () {
      setUp(() {
        var mascot = getMascotModel();
        when(context.mocks.mascotsLocalDataSource.streamObject(any)).thenAnswer(
          (_) => Single.value(mascot.copyWith(
              expressions: mascot.expressions
                  .map((e) => ExpressionModel.empty().copyWith(id: e.id))
                  .toList())),
        );
      });

      test('should seed the stream with the current value', () async {
        //act
        final result =
            await repository.streamMascot(context.data.mascot.id).single;

        // assert
        expect(result, context.data.mascot);
        verify(
          context.mocks.mascotsLocalDataSource
              .streamObject(context.data.mascot.id),
        );
        verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
      });

      test(
        'should populate the expressions on the Mascot object that seeds the stream when invoking streamMascot',
        () async {
          // act
          final result =
              await repository.streamMascot(context.data.mascot.id).single;

          // assert
          expect(result, context.data.mascot);

          verify(
            context.mocks.expressionsLocalDataSource.getObjects(
                context.data.mascot.expressions.map((e) => e.id).toList()),
          );
          verifyNoMoreInteractions(context.mocks.expressionsLocalDataSource);
        },
      );
    });
  });
}
