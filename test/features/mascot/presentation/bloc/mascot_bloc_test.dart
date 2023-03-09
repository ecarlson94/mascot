import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mascot/features/mascot/domain/entities/mascot.dart';
import 'package:mascot/features/mascot/presentation/bloc/mascot_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../fixtures/option.dart';
import '../../../../fixtures/test_context.dart';

void main() {
  group('MascotBloc', () {
    late TestContext context;
    late MascotBloc bloc;
    late BehaviorSubject<Mascot> mascotSubject;

    setUp(() {
      context = TestContext();
      bloc = MascotBloc(context.mocks.streamMascot);
      mascotSubject = BehaviorSubject<Mascot>.seeded(context.data.mascot);

      when(context.mocks.streamMascot(any))
          .thenAnswer((_) async => Right(mascotSubject));
    });

    test('initial state is MascotInitial', () {
      // assert
      expect(bloc.state, MascotInitial(none()));
    });

    group('LoadMascotStream', () {
      blocTest(
        'should emit [MascotLoaded] when retrieval of mascot is successful',
        build: () => bloc,
        act: (bloc) => bloc.add(LoadMascotStream(context.data.mascot.id)),
        expect: () => [
          MascotLoading(none()),
          isA<MascotLoaded>(),
        ],
      );

      blocTest(
        'should use stream retrieved from usecase',
        build: () => bloc,
        act: (bloc) => {
          bloc.add(LoadMascotStream(context.data.mascot.id)),
        },
        verify: (bloc) async {
          var mascotStreamOption = bloc.state.mascotStreamOption;
          expect(mascotStreamOption, isSome);
          var stream = mascotStreamOption.getOrFailTest();
          expect(stream, emits(context.data.mascot));

          var newMascot = context.data.mascot.copyWith(name: 'new name');
          mascotSubject.add(newMascot);
          await expectLater(stream, emits(newMascot));
        },
      );
    });
  });
}
