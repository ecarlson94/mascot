import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/core/utils/input_converters/convert_xfile_to_image.dart';
import 'package:mascot/features/expressions/data/models/image_model.dart';
import 'package:mascot/features/expressions/domain/entities/image.dart';
import 'package:mascot/features/expressions/presentation/bloc/expression_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/empty_failure.dart';
import '../../../../fixtures/test_context.dart';

void main() {
  late TestContext context;
  late ExpressionBloc bloc;

  setUp(() {
    context = TestContext();
    bloc = ExpressionBloc(
      context.mocks.getExpression,
      context.mocks.addExpression,
      ConvertXfileToImage(),
    );
  });

  group('ImageBloc', () {
    test('initialState should be ExpressionInitial', () {
      // assert
      expect(bloc.state, ExpressionInitial());
    });

    void setupMockSaveExpressionSuccess() =>
        when(context.mocks.addExpression(any))
            .thenAnswer((_) async => Right(context.data.expression.id));
    void setupMockGetExpressionSuccess() =>
        when(context.mocks.getExpression(any))
            .thenAnswer((_) async => Right(context.data.expression));

    group('SaveExpressionEvent', () {
      late ImageModel xfileImage;
      setUp(
        () async => xfileImage = ImageModel(
          name: context.data.xfile.name,
          data: await context.data.xfile.readAsBytes(),
        ),
      );

      blocTest(
        'should emit [ExpressionSaveError($ErrorCodes.invalidXfileFailureCode)] when the input is invalid',
        build: () => bloc,
        act: (bloc) => bloc.add(SaveExpressionEvent(
          name: context.data.expression.name,
          description: context.data.expression.description,
          image: XFile(''),
        )),
        expect: () =>
            [const SaveExpressionError(ErrorCodes.invalidXfileFailureCode)],
      );

      blocTest(
        'should emit [SavingExpression, GettingExpression, ExpressionLoaded] when data is retrieved successfully',
        build: () {
          setupMockSaveExpressionSuccess();
          setupMockGetExpressionSuccess();
          return bloc;
        },
        act: (bloc) => bloc.add(SaveExpressionEvent(
          name: context.data.expression.name,
          description: context.data.expression.description,
          image: context.data.xfile,
        )),
        expect: () {
          var expression = context.data.expression.copyWith(
            id: 0,
            image: Image(name: xfileImage.name, data: xfileImage.data),
          );
          verify(
            context.mocks.addExpression(expression),
          );
          return [
            SavingExpression(),
            GettingExpression(),
            ExpressionLoaded(context.data.expressionModel),
          ];
        },
      );

      blocTest(
        'should emit [SavingExpression, ExpressionSaveError($ErrorCodes.addImageFailureCode)] when data retrieval from the local data source fails',
        build: () {
          when(context.mocks.addExpression(any))
              .thenAnswer((_) async => Left(LocalDataSourceFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(SaveExpressionEvent(
          name: context.data.expression.name,
          description: context.data.expression.description,
          image: context.data.xfile,
        )),
        expect: () => [
          SavingExpression(),
          const SaveExpressionError(ErrorCodes.addImageFailureCode),
        ],
      );

      blocTest(
        'should emit [SavingExpression, ExpressionSaveError(0)] after validation when an unkown failure occurs',
        build: () {
          when(context.mocks.addExpression(any))
              .thenAnswer((_) async => Left(EmptyFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(SaveExpressionEvent(
          name: context.data.expression.name,
          description: context.data.expression.description,
          image: context.data.xfile,
        )),
        expect: () => [SavingExpression(), const SaveExpressionError(0)],
      );
    });

    group('GetExpression', () {
      blocTest(
        'should emit [GetExpressionError($ErrorCodes.getImageFailureCode)] when data retrieval from the local data source fails',
        build: () {
          when(context.mocks.getExpression(any))
              .thenAnswer((_) async => Left(LocalDataSourceFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(const GetExpressionEvent(id: 0)),
        expect: () => [
          GettingExpression(),
          const GetExpressionError(ErrorCodes.getImageFailureCode),
        ],
      );

      blocTest(
        'should emit [GettingExpression, ExpressionLoaded] when data is retrieved succfully',
        build: () {
          setupMockGetExpressionSuccess();
          return bloc;
        },
        act: (bloc) {
          bloc.add(GetExpressionEvent(id: context.data.expression.id));
        },
        expect: () {
          verify(context.mocks.getExpression(context.data.expression.id));
          return [
            GettingExpression(),
            ExpressionLoaded(context.data.expression),
          ];
        },
      );

      blocTest(
        'should emit [GettingExpression, GetExpressionError(0)] when an unkown failure occurs',
        build: () {
          when(context.mocks.getExpression(any))
              .thenAnswer((_) async => Left(EmptyFailure()));
          return bloc;
        },
        act: (bloc) => bloc.add(
          GetExpressionEvent(id: context.data.expression.id),
        ),
        expect: () => [GettingExpression(), const GetExpressionError(0)],
      );
    });

    group('SetExpressionEvent', () {
      blocTest(
        'should emit [ExpressionLoaded] with the provided expression',
        build: () => bloc,
        act: (bloc) => bloc.add(
          SetExpressionEvent(expression: context.data.expression),
        ),
        expect: () {
          return [
            ExpressionLoaded(context.data.expression),
          ];
        },
      );
    });
  });
}
