import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/images/domain/usecases/save_image.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late SaveImage usecase;

  setUp(() {
    context = TestContext();
    usecase = SaveImage(context.mocks.mockImagesRepository);
  });

  test('should save the provided image to the repository', () async {
    // arrange
    when(context.mocks.mockImagesRepository.saveImage(any))
        .thenAnswer((_) async => Right(context.data.image));

    // act
    final result = await usecase(context.data.image);

    // assert
    expect(result, Right(context.data.image));
    verify(context.mocks.mockImagesRepository.saveImage(context.data.image));
    verifyNoMoreInteractions(context.mocks.mockImagesRepository);
  });
}
