import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/mascot.dart';
import '../../domain/usecases/stream_mascot.dart';

part 'mascot_event.dart';
part 'mascot_state.dart';

class MascotBloc extends Bloc<MascotEvent, MascotState> {
  final StreamMascot streamMascot;

  MascotBloc(this.streamMascot) : super(MascotInitial(none())) {
    on<MascotEvent>((event, emit) async {
      if (event is LoadMascotStream) {
        emit(MascotLoading(none()));

        var failureOrMascotStream = await streamMascot(event.mascotId);
        failureOrMascotStream.fold(
          (l) => emit(MascotError(ErrorCodes.loadMascotFailureCode, none())),
          (stream) => emit(MascotLoaded(some(stream))),
        );
      }
    });
  }
}
