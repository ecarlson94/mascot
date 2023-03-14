import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/core/clean_architecture/entity.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/features/mascot/data/datasources/hive/models/map_mascot_to_hive_mascot.dart';
import 'package:mascot/features/mascot/data/models/mascot_model.dart';
import 'package:mascot/features/mascot/data/repositories/mascots_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../fixtures/option.dart';
import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MascotsRepositoryImpl repository;
  late MapMascotToHiveMascot mapMasoctToHiveMascot;
  late List<Id> expressionIds;

  setUp(() {
    context = TestContext();
    mapMasoctToHiveMascot = context.data.mapMascotToHiveMascot;
    repository = MascotsRepositoryImpl(
      context.mocks.mascotsLocalDataSource,
      mapMasoctToHiveMascot,
    );

    expressionIds = context.data.mascot.expressions.map((e) => e.id).toList();

    when(context.mocks.expressionsRepository.addExpressions(any))
        .thenAnswer((_) => Future.value(Right(expressionIds)));
    when(context.mocks.expressionsRepository.getExpressions(any)).thenAnswer(
      (_) => Future.value(
        Right(context.data.mascot.expressions.toList()),
      ),
    );
    when(context.mocks.mascotsLocalDataSource.getMascot(any))
        .thenAnswer((_) => Future.value(context.data.hiveMascot));
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
            mapMasoctToHiveMascot.map(context.data.mascot),
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
              mapMasoctToHiveMascot.map(context.data.mascot),
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
              mapMasoctToHiveMascot.map(context.data.mascot),
            ),
          );
          verifyNoMoreInteractions(context.mocks.mascotsLocalDataSource);
        },
      );
    });

    group('streamMascot', () {
      late BehaviorSubject<MascotModel?> modelStream;
      setUp(() {
        modelStream = BehaviorSubject<MascotModel>();

        when(context.mocks.mascotsLocalDataSource.getMascot(any))
            .thenAnswer((_) async => context.data.hiveMascot);
        when(context.mocks.mascotsLocalDataSource.streamMascot(any))
            .thenAnswer((_) async => modelStream);
      });

      test('should seed the stream with the current value', () async {
        //act
        final result = await repository.streamMascot(context.data.mascot.id);

        // assert
        var subject = result.getOrFailTest();
        expect(
          subject,
          emitsInOrder([
            context.data.hiveMascot,
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
