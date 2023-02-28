import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/core/utils/input_converters/input_converter.dart';
import 'package:mascot/features/images/presentation/bloc/image_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/empty_failure.dart';
import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late ImageBloc bloc;

  setUp(() {
    context = TestContext();
    bloc = ImageBloc(
      context.mocks.getImage,
      context.mocks.saveImage,
      context.mocks.convertXfileToImage,
    );
  });

  test('initialState should be ImageInitial', () {
    // assert
    expect(bloc.state, ImageInitial());
  });

  void setupMockInputConverterSuccess() =>
      when(context.mocks.convertXfileToImage(any))
          .thenAnswer((_) async => Right(context.data.image));
  void setupMockSaveImageSuccess() => when(context.mocks.saveImage(any))
      .thenAnswer((_) async => Right(context.data.image));
  void setupMockGetImageSuccess() => when(context.mocks.getImage(any))
      .thenAnswer((_) async => Right(context.data.image));

  group('SaveImageEvent', () {
    blocTest(
      'should call the InputConverter to validate and convert the xfile to an Image',
      build: () {
        setupMockInputConverterSuccess();
        setupMockSaveImageSuccess();
        return bloc;
      },
      act: (bloc) => bloc.add(SaveImageEvent(image: context.data.xfile)),
      expect: () {
        verify(context.mocks.convertXfileToImage(context.data.xfile));
        return [
          SavingImage(),
          ImageLoaded(context.data.image),
        ];
      },
    );

    blocTest(
      'should emit [ImageSaveError($invalidXfileFailureCode)] when the input is invalid',
      build: () {
        when(context.mocks.convertXfileToImage(any))
            .thenAnswer((_) async => Left(InvalidInputFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(SaveImageEvent(image: XFile(''))),
      expect: () => [const SaveImageError(invalidXfileFailureCode)],
    );

    blocTest(
      'should emit [SavingImage, ImageLoaded] when data is retrieved succfully',
      build: () {
        setupMockInputConverterSuccess();
        when(context.mocks.saveImage(any))
            .thenAnswer((_) async => Right(context.data.image));
        return bloc;
      },
      act: (bloc) {
        bloc.add(SaveImageEvent(image: context.data.xfile));
      },
      expect: () {
        verify(context.mocks.convertXfileToImage(context.data.xfile));
        verify(context.mocks.saveImage(context.data.image));
        return [
          SavingImage(),
          ImageLoaded(context.data.image),
        ];
      },
    );

    blocTest(
      'should emit [SavingImage, ImageSaveError($saveImageFailureCode)] when data retrieval from the local data source fails',
      build: () {
        setupMockInputConverterSuccess();
        when(context.mocks.saveImage(any))
            .thenAnswer((_) async => Left(LocalDataSourceFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(SaveImageEvent(image: context.data.xfile)),
      expect: () => [SavingImage(), const SaveImageError(saveImageFailureCode)],
    );

    blocTest(
      'should emit [SavingImage, ImageSaveError(0)] after validation when an unkown failure occurs',
      build: () {
        setupMockInputConverterSuccess();
        when(context.mocks.saveImage(any))
            .thenAnswer((_) async => Left(EmptyFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(SaveImageEvent(image: context.data.xfile)),
      expect: () => [SavingImage(), const SaveImageError(0)],
    );

    blocTest(
      'should emit [ImageSaveError(0)] during validation when an unkown failure occurs',
      build: () {
        when(context.mocks.convertXfileToImage(any))
            .thenAnswer((_) async => Left(EmptyFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(SaveImageEvent(image: context.data.xfile)),
      expect: () => [const SaveImageError(0)],
    );
  });

  group('GetImageImage', () {
    blocTest(
      'should emit [GetImageError($getImageFailureCode)] when data retrieval from the local data source fails',
      build: () {
        when(context.mocks.getImage(any))
            .thenAnswer((_) async => Left(LocalDataSourceFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetImageEvent(id: 0)),
      expect: () => [GettingImage(), const GetImageError(getImageFailureCode)],
    );

    blocTest(
      'should emit [GettingImage, ImageLoaded] when data is retrieved succfully',
      build: () {
        setupMockInputConverterSuccess();
        setupMockGetImageSuccess();
        return bloc;
      },
      act: (bloc) {
        bloc.add(GetImageEvent(id: context.data.image.id));
      },
      expect: () {
        verify(context.mocks.getImage(context.data.image.id));
        return [
          GettingImage(),
          ImageLoaded(context.data.image),
        ];
      },
    );

    blocTest(
      'should emit [GettingImage, GetImageError(0)] when an unkown failure occurs',
      build: () {
        setupMockInputConverterSuccess();
        when(context.mocks.getImage(any))
            .thenAnswer((_) async => Left(EmptyFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetImageEvent(id: context.data.image.id)),
      expect: () => [GettingImage(), const GetImageError(0)],
    );
  });

  group('SetImageEvent', () {
    blocTest(
      'should emit [ImageLoaded] with the provided image',
      build: () => bloc,
      act: (bloc) => bloc.add(SetImageEvent(image: context.data.image)),
      expect: () {
        return [
          ImageLoaded(context.data.image),
        ];
      },
    );
  });
}
