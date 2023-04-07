import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/entity.dart';
import 'package:mascot/core/error/failure.dart';
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

    when(context.mocks.mascotsLocalDataSource.getObject(any))
        .thenAnswer((_) => Future.value(getMascotModel()));
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
    });
  });
}
