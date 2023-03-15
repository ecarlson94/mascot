import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/mascot/data/datasources/drift/models/drift_mascot.dart';
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../fixtures/option.dart';
import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MascotsRepositoryImpl repository;

  DriftMascot getMascotModel() =>
      context.data.mapMascotToMascotModel.map(context.data.mascot);

  setUp(() {
    context = TestContext();
    repository = MascotsRepositoryImpl(
      context.mocks.mascotsLocalDataSource,
      context.data.mapMascotToMascotModel,
    );

    when(context.mocks.mascotsLocalDataSource.getMascot(any))
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
            getMascotModel(),
          );

          verify(context.mocks.mascotsLocalDataSource
              .getMascot(context.data.mascot.id));
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );

      test(
        'should return failure when call to local data source is unsuccessful',
        () async {
          // arrange
          when(context.mocks.mascotsLocalDataSource.getMascot(any))
              .thenThrow(Exception());

          // act
          final result = await repository.getMascot(context.data.mascot.id);

          // assert
          expect(result, Left(LocalDataSourceFailure()));

          verify(context.mocks.mascotsLocalDataSource
              .getMascot(context.data.mascot.id));
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );
    });

    group('addMascot', () {
      setUp(() async {
        when(context.mocks.mascotsLocalDataSource.addMascot(any))
            .thenAnswer((_) => Future.value(context.data.mascot.id));
      });

      test(
        'should return the id of the added mascot when call to local data source is successful',
        () async {
          // act
          final result = await repository.addMascot(context.data.mascot);

          // assert
          expect(result, Right(context.data.mascot.id));

          verify(
            context.mocks.mascotsLocalDataSource.addMascot(
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
          when(context.mocks.mascotsLocalDataSource.addMascot(any))
              .thenThrow(Exception());

          // act
          final result = await repository.addMascot(context.data.mascot);

          // assert
          expect(result, Left(LocalDataSourceFailure()));

          verify(
            context.mocks.mascotsLocalDataSource.addMascot(
              getMascotModel(),
            ),
          );
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );
    });

    group('streamMascot', () {
      late BehaviorSubject<DriftMascot> modelStream;
      setUp(() {
        modelStream = BehaviorSubject<DriftMascot>();

        when(context.mocks.mascotsLocalDataSource.getMascot(any))
            .thenAnswer((_) async => getMascotModel());
        when(context.mocks.mascotsLocalDataSource.streamMascot(any))
            .thenAnswer((_) async => modelStream);
      });

      // TODO: move to drift datasource test
      test('should seed the stream with the current value', () async {
        //act
        final result = await repository.streamMascot(context.data.mascot.id);

        // assert
        var subject = result.getOrFailTest();
        expect(
          subject,
          emitsInOrder([
            getMascotModel(),
          ]),
        );
        verify(
          context.mocks.mascotsLocalDataSource
              .getMascot(context.data.mascot.id),
        );
        verify(
          context.mocks.mascotsLocalDataSource
              .streamMascot(context.data.mascot.id),
        );
        verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
      });

      test(
        'should return failure when call to local data source is unsuccessful',
        () async {
          // arrange
          when(context.mocks.mascotsLocalDataSource.streamMascot(any))
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
