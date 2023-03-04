import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mascot/features/images/data/datasources/images_collection.dart';
import 'package:mascot/features/images/data/models/image_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

class IsarImagesCollectionImpl extends IsarImagesCollection {}

class HiveImagesCollectionImpl extends HiveImagesCollection {}

class MockIsarCollection<T> extends Mock implements IsarCollection<T> {}

void main() {
  late TestContext context;
  setUp(() {
    context = TestContext();
  });

  group('IsarImagesCollection', () {
    late IsarImagesCollection isarImagesCollection;
    late IsarCollection<ImageModel> isarCollection;
    setUp(() {
      isarImagesCollection = IsarImagesCollectionImpl();
      isarCollection = MockIsarCollection<ImageModel>();
    });

    test('should return isar collection', () {
      // arrange
      when(context.mocks.isar.collection<ImageModel>())
          .thenReturn(isarCollection);

      // act
      final collection = isarImagesCollection.create(context.mocks.isar);

      // assert
      expect(collection, isarCollection);
    });
  });

  group('HiveImagesCollection', () {
    late HiveImagesCollectionImpl hiveImagesCollection;
    setUp(() {
      hiveImagesCollection = HiveImagesCollectionImpl();
      when(context.mocks.hiveInterface.openBox<ImageModel>(any))
          .thenAnswer((_) async => context.mocks.hiveImageBox);
    });

    test('should open ImageModel box for hive', () async {
      // act
      final box =
          await hiveImagesCollection.create(context.mocks.hiveInterface);

      // assert
      verify(context.mocks.hiveInterface.openBox<ImageModel>('images'));
      expect(box, context.mocks.hiveImageBox);
    });

    test('should register ImageModel adapter for hive', () async {
      // act
      await hiveImagesCollection.create(context.mocks.hiveInterface);

      // assert
      verify(context.mocks.hiveInterface.registerAdapter(ImageModelAdapter()));
    });
  });
}
