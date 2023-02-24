import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/images/domain/entities/image.dart';
import 'package:mascot/features/images/domain/usecases/get_image.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late GetImage usecase;

  setUp(() {
    context = TestContext();
    usecase = GetImage(context.mocks.mockImagesRepository);
  });

  const Image expected = Image(id: 1);

  test('should get the requested image from the repository', () async {
    // arrange
    when(context.mocks.mockImagesRepository.getImage(any))
        .thenAnswer((_) async => const Right(expected));

    // act
    final result = await usecase(expected.id);

    // assert
    expect(result, const Right(expected));
    verify(context.mocks.mockImagesRepository.getImage(expected.id));
    verifyNoMoreInteractions(context.mocks.mockImagesRepository);
  });
}
