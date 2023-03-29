import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/presentation/bloc/create_mascot_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/test_context.dart';

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
      expect(bloc.state, CreateMascotInitial(none()));
    });
  });
}
