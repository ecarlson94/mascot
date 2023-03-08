import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/data/datasources/mascots_local_data_source.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late MascotsLocalDataSourceImpl dataSource;

  setUp(() {
    context = TestContext();
    dataSource = MascotsLocalDataSourceImpl(
      context.mocks.mascotsCollectionAdapter,
    );
  });

  group('MascotsLocalDataSourceImpl', () {
    group('getMascot', () {
      test('should return MascotModel from local database', () async {
        // arrange
        when(context.mocks.mascotsCollectionAdapter.get(any))
            .thenAnswer((_) async => context.data.mascotModel);

        // act
        final result = await dataSource.getMascot(1);

        // assert
        expect(result, context.data.mascotModel);
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
          final result = await dataSource.addMascot(context.data.mascotModel);

          // assert
          expect(result, equals(id));
          verify(context.mocks.mascotsCollectionAdapter
              .add(context.data.mascotModel));
          verifyNoMoreInteractions(context.mocks.mascotsCollectionAdapter);
        },
      );
    });

    group('streamMascot', () {
      test('should stream MascotModel from local database', () async {
        // arrange
        var expectedStream = BehaviorSubject.seeded(context.data.mascotModel);
        when(context.mocks.mascotsCollectionAdapter.stream(any))
            .thenAnswer((_) async => expectedStream);

        // act
        final result = await dataSource.streamMascot(1);

        // assert
        expect(result, expectedStream);
        verify(context.mocks.mascotsCollectionAdapter.stream(1));
        verifyNoMoreInteractions(context.mocks.mascotsCollectionAdapter);
      });
    });
  });
}
