import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/images/domain/usecases/add_image.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late AddImage usecase;

  setUp(() {
    context = TestContext();
    usecase = AddImage(context.mocks.imagesRepository);
  });

  test(
    'AddImage usecase should save the provided image to the repository',
    () async {
      // arrange
      when(context.mocks.imagesRepository.addImage(any))
          .thenAnswer((_) async => Right(context.data.image.id));

      // act
      final result = await usecase(context.data.image);

      // assert
      expect(result, Right(context.data.image.id));
      verify(context.mocks.imagesRepository.addImage(context.data.image));
      verifyNoMoreInteractions(context.mocks.imagesRepository);
    },
  );
}
