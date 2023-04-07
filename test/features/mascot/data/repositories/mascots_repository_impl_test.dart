import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/entity.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/expressions/data/models/expression_model.dart';
import 'package:mascot/features/mascot/data/models/mascot_model.dart';
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../fixtures/option.dart';
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
        .thenAnswer((_) async => mascotModel);
    when(context.mocks.expressionsLocalDataSource.getObjects(any))
        .thenAnswer((_) async => getMascotModel().expressions);
  });

  group('MascotsRepositoryImpl', () {
    group('getMascot', () {
      test(
        'should return the requested mascot when call to local data source is successful',
        () async {
          // act
          final result = await repository.getMascot(context.data.mascot.id);
          final mascot = result.getOrFailTest();

          // assert
          expect(
            mascot,
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
          (_) async => mascotModel.copyWith(
            expressions: mascotModel.expressions
                .map((e) => ExpressionModel.empty().copyWith(id: e.id))
                .toList(),
          ),
        );

        // act
        await repository.getMascot(context.data.mascot.id);

        // assert
        verify(context.mocks.expressionsLocalDataSource
            .getObjects(mascotModel.expressions.map((e) => e.id)));
        verifyNoMoreInteractions(context.mocks.expressionsLocalDataSource);
      });

      test(
        'should return failure when call to local data source is unsuccessful',
        () async {
          // arrange
          when(context.mocks.mascotsLocalDataSource.getObject(any))
              .thenThrow(Exception());

          // act
          final result = await repository.getMascot(context.data.mascot.id);

          // assert
          expect(result, Left(LocalDataSourceFailure()));

          verify(context.mocks.mascotsLocalDataSource
              .getObject(context.data.mascot.id));
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );

      test(
        'should populate the expressions on the Mascot object when invoking getMascot',
        () async {
          // act
          final result = await repository.getMascot(context.data.mascot.id);
          final mascot = result.getOrFailTest();

          // assert
          expect(mascot.expressions, context.data.mascot.expressions);

          verify(context.mocks.mascotsLocalDataSource
              .getObject(context.data.mascot.id));
          verify(context.mocks.expressionsLocalDataSource
              .getObjects(context.data.mascot.expressions.map((e) => e.id)));
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
          verifyNoMoreInteractions(context.mocks.expressionsLocalDataSource);
        },
      );
    });

    group('saveMascot', () {
      setUp(() async {
        when(context.mocks.mascotsLocalDataSource.putObject(any))
            .thenAnswer((_) => Future.value(context.data.mascot.id));
      });

      test(
        'should return the id of the added mascot when call to local data source is successful',
        () async {
          // act
          final result = await repository.saveMascot(context.data.mascot);

          // assert
          expect(result, Right(context.data.mascot.id));

          verify(
            context.mocks.mascotsLocalDataSource.putObject(
              getMascotModel(),
            ),
          );
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );

      test(
        'should return failure when call to local data source is unsuccessful',
        () async {
          // arrange
          when(context.mocks.mascotsLocalDataSource.putObject(any))
              .thenThrow(Exception());

          // act
          final result = await repository.saveMascot(context.data.mascot);

          // assert
          expect(result, Left(LocalDataSourceFailure()));

          verify(
            context.mocks.mascotsLocalDataSource.putObject(
              getMascotModel(),
            ),
          );
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );

      test(
        'should return InvalidArgumentFailure when mascot has expressions without ids',
        () async {
          // arrange
          final mascot = context.data.mascot.copyWith(
            expressions: {
              context.data.expression.copyWith(id: 0),
              context.data.expression,
            },
          );

          // act
          final result = await repository.saveMascot(mascot);

          // assert
          expect(result, Left<Failure, Id>(InvalidArgumentFailure()));
        },
      );
    });

    group('streamMascot', () {
      late BehaviorSubject<MascotModel> modelStream;
      setUp(() {
        modelStream = BehaviorSubject<MascotModel>();

        when(context.mocks.mascotsLocalDataSource.getObject(any))
            .thenAnswer((_) async => getMascotModel());
        when(context.mocks.mascotsLocalDataSource.streamObject(any))
            .thenAnswer((_) => modelStream);
      });

      test('should seed the stream with the current value', () async {
        //act
        final result = await repository.streamMascot(context.data.mascot.id);

        // assert
        var subject = result.getOrFailTest();
        expect(
          subject,
          emitsInOrder([
            context.data.mascotMapper.toMascot(getMascotModel()),
          ]),
        );
        verify(
          context.mocks.mascotsLocalDataSource
              .getObject(context.data.mascot.id),
        );
        verify(
          context.mocks.mascotsLocalDataSource
              .streamObject(context.data.mascot.id),
        );
        verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
      });

      test(
        'should return failure when call to local data source is unsuccessful',
        () async {
          // arrange
          when(context.mocks.mascotsLocalDataSource.streamObject(any))
              .thenThrow(Exception());

          // act
          final result = await repository.streamMascot(context.data.mascot.id);

          // assert
          expect(result, Left(LocalDataSourceFailure()));
        },
      );

      test(
        'should populate the expressions on the Mascot object that seeds the stream when invoking streamMascot',
        () async {
          // act
          final result = await repository.streamMascot(context.data.mascot.id);
          final subject = result.getOrFailTest();

          // assert
          expect(
            subject,
            emitsInOrder([
              context.data.mascot,
            ]),
          );

          verify(context.mocks.mascotsLocalDataSource
              .getObject(context.data.mascot.id));
          verify(context.mocks.mascotsLocalDataSource
              .streamObject(context.data.mascot.id));
          verify(context.mocks.expressionsLocalDataSource
              .getObjects(context.data.mascot.expressions.map((e) => e.id)));
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
          verifyNoMoreInteractions(context.mocks.expressionsLocalDataSource);
        },
      );

      test(
        'should populate the expressions on the Mascot object that is added to the stream when invoking streamMascot',
        () async {
          // arrange
          final updatedMascot = context.data.mascot.copyWith(id: 2);
          final updatedMascotModel =
              context.data.mascotMapper.fromMascot(updatedMascot);

          // act
          final result = await repository.streamMascot(context.data.mascot.id);
          final subject = result.getOrFailTest();

          modelStream.add(updatedMascotModel);

          // assert
          expect(
            subject,
            emitsInOrder([
              context.data.mascot,
              updatedMascot,
            ]),
          );

          verify(context.mocks.mascotsLocalDataSource
              .getObject(context.data.mascot.id));
          verify(context.mocks.mascotsLocalDataSource
              .streamObject(context.data.mascot.id));
          verify(context.mocks.expressionsLocalDataSource
              .getObjects(context.data.mascot.expressions.map((e) => e.id)));
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
          verifyNoMoreInteractions(context.mocks.expressionsLocalDataSource);
        },
      );
    });
  });
}
