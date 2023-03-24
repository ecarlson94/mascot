import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascot/core/error/error.dart';
import 'package:mascot/core/error/failure.dart';
import 'package:mascot/core/utils/constants.dart';
import 'package:mascot/features/expressions/domain/entities/expression.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';
import '../../../../fixtures/test_data.dart';
import '../../../../fixtures/test_x_file.dart';

void main() {
  group('CreateMascotBloc', () {
    late TestContext context;
    late CreateMascotBloc bloc;

    setUp(() {
      context = TestContext();
      bloc = CreateMascotBloc(
        context.mocks.addMascot,
      );

      when(context.mocks.addMascot(any))
          .thenAnswer((_) async => Right(context.data.mascot));
    });

    test('initialState should be CreateMascotInitial', () {
      // assert
      expect(bloc.state, const CreateMascotInitial(Mascot.empty));
    });

    var uploadExpressionEvents = [
      {
        'type': UploadNeutralExpression,
        'expressionId': 1,
        'expressionName': defaultExpressionName,
        'expressionDescription': CreateMascotBloc.neutralExpressionDescription,
        'invalidXFileUpload': UploadNeutralExpression(XFile('')),
        'validXFileUpload': UploadNeutralExpression(TestData().xfile),
        'secondValidXFileUpload': UploadNeutralExpression(
          TestXFile.fromData(Uint8List(5), name: 'a new name'),
        ),
      },
      {
        'type': UploadTalkingExpression,
        'expressionId': 2,
        'expressionName': talkingExpressionName,
        'expressionDescription': CreateMascotBloc.talkingExpressionDescription,
        'invalidXFileUpload': UploadTalkingExpression(XFile('')),
        'validXFileUpload': UploadTalkingExpression(TestData().xfile),
        'secondValidXFileUpload': UploadTalkingExpression(
          TestXFile.fromData(Uint8List(5), name: 'a new name'),
        ),
      }
    ];
    for (var params in uploadExpressionEvents) {
      group('${params['type']}', () {
        Mascot getSavingExpressionMascot() => Mascot.empty.copyWith(
              expressions: {
                Expression.empty.copyWith(
                  name: params['expressionName'] as String,
                  description: params['expressionDescription'] as String,
                  image: context.data.xfile.data,
                )
              },
            );

        blocTest(
          'should emit [SavingExpression, MascotUpdated] when upload is successful',
          build: () => bloc,
          act: (bloc) =>
              bloc.add(params['validXFileUpload'] as CreateMascotEvent),
          expect: () => [
            SavingExpression(getSavingExpressionMascot()),
            MascotUpdated(context.data.mascot),
          ],
        );

        blocTest(
          'should add the correct expression to the mascot when upload is successful',
          build: () => bloc,
          act: (bloc) =>
              bloc.add(params['validXFileUpload'] as CreateMascotEvent),
          verify: (bloc) => verify(
            context.mocks.addMascot(getSavingExpressionMascot()),
          ),
        );

        blocTest<CreateMascotBloc, CreateMascotState>(
          'should update the correct expression on the mascot when the expression already exists',
          build: () => bloc,
          seed: () => CreateMascotInitial(context.data.mascot),
          act: (bloc) =>
              bloc.add(params['secondValidXFileUpload'] as CreateMascotEvent),
          verify: (bloc) => verify(
            context.mocks.addMascot(
              context.data.mascot.copyWith(
                expressions: {
                  ...context.data.mascot.expressions.where(
                    (e) => e.name != params['expressionName'],
                  ),
                  Expression(
                    id: params['expressionId'] as int,
                    name: params['expressionName'] as String,
                    description: params['expressionDescription'] as String,
                    image: Uint8List(5),
                  ),
                },
              ),
            ),
          ),
        );

        blocTest(
          'should emit [SavingExpression, SaveMascotError(${ErrorCodes.saveMascotFailureCode})] when upload fails',
          build: () => bloc,
          setUp: () {
            when(context.mocks.addMascot(any))
                .thenAnswer((_) async => Left(LocalDataSourceFailure()));
          },
          act: (bloc) =>
              bloc.add(params['validXFileUpload'] as CreateMascotEvent),
          expect: () => [
            SavingExpression(getSavingExpressionMascot()),
            SaveMascotError(
              ErrorCodes.saveMascotFailureCode,
              getSavingExpressionMascot(),
            ),
          ],
        );
      });
    }

    group('SetMascotName', () {
      const validName = 'a valid name';

      blocTest(
        'should emit [MascotUpdated, MascotUpdated] when the name is valid',
        build: () => bloc,
        act: (bloc) => bloc.add(const SetMascotName(validName)),
        expect: () => [
          MascotUpdated(
            Mascot.empty.copyWith(name: validName),
          ), // Name is set in state
          MascotUpdated(
            context.data.mascot,
          ), // Name is set in persistant storage
        ],
      );
    });
  });
}
