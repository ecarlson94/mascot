import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/images/domain/usecases/get_image.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late GetImage usecase;

  setUp(() {
    context = TestContext();
    usecase = GetImage(context.mocks.imagesRepository);
  });

  test('should get the requested image from the repository', () async {
    // arrange
    when(context.mocks.imagesRepository.getImage(any))
        .thenAnswer((_) async => Right(context.data.image));

    // act
    final result = await usecase(context.data.image.id);

    // assert
    expect(result, Right(context.data.image));
    verify(context.mocks.imagesRepository.getImage(context.data.image.id));
    verifyNoMoreInteractions(context.mocks.imagesRepository);
  });
}
