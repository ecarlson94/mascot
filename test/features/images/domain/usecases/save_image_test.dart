import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/images/domain/entities/image.dart';
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

  const Image expected = Image(id: 1);

  test('should save the provided image to the repository', () async {
    // arrange
    when(context.mocks.mockImagesRepository.saveImage(any))
        .thenAnswer((_) async => const Right(expected));

    // act
    final result = await usecase(expected);

    // assert
    expect(result, const Right(expected));
    verify(context.mocks.mockImagesRepository.saveImage(expected));
    verifyNoMoreInteractions(context.mocks.mockImagesRepository);
  });
}
