import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/data/datasources/hive/mascots_hive_data_source.dart';
import 'package:mascot/features/mascot/data/models/mascot_model.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MascotsHiveDataSourceImpl dataSource;

  setUp(() {
    context = TestContext();
    dataSource = MascotsHiveDataSourceImpl(
      context.mocks.mascotsCollectionAdapter,
      context.mocks.expressionsHiveDataSource,
      context.data.mapMascotToHiveMascot,
    );

    when(context.mocks.mascotsCollectionAdapter.get(any))
        .thenAnswer((_) async => context.data.hiveMascot);
    when(context.mocks.expressionsHiveDataSource.getExpressions(any))
        .thenAnswer((_) async => context.data.hiveMascot.expressions.toList());
    when(context.mocks.expressionsHiveDataSource.addExpression(any))
        .thenAnswer((_) async => 1);
  });

  group('MascotsHiveDataSourceImpl', () {
    group('getMascot', () {
      test('should return MascotModel from local database', () async {
        // act
        final result = await dataSource.getMascot(1);

        // assert
        expect(result, context.data.hiveMascot);
        verify(context.mocks.mascotsCollectionAdapter.get(1));
        verifyNoMoreInteractions(context.mocks.mascotsCollectionAdapter);
      });
    });

    group('addMascot', () {
      test(
        'should return new mascot id from local database after adding mascot to database',
        () async {
          // arrange
          var id = 1;
          when(context.mocks.mascotsCollectionAdapter.add(any))
              .thenAnswer((_) async => id);

          // act
          final result = await dataSource.addMascot(context.data.hiveMascot);

          // assert
          expect(result, equals(id));
          verify(context.mocks.mascotsCollectionAdapter
              .add(context.data.hiveMascot));
          verifyNoMoreInteractions(context.mocks.mascotsCollectionAdapter);
        },
      );
    });

    group('streamMascot', () {
      test('should stream MascotModel from local database', () async {
        // arrange
        when(context.mocks.mascotsCollectionAdapter.stream(any)).thenAnswer(
            (_) async => BehaviorSubject.seeded(context.data.hiveMascot));

        // act
        final result = await dataSource.streamMascot(1);

        // assert
        expect(result, isA<Stream<MascotModel?>>());
        verify(context.mocks.mascotsCollectionAdapter.stream(1));
        verifyNoMoreInteractions(context.mocks.mascotsCollectionAdapter);
      });
    });
  });
}
