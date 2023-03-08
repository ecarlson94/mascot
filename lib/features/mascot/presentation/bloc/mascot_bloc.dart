import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/mascot.dart';

part 'mascot_event.dart';
part 'mascot_state.dart';

class MascotBloc extends Bloc<MascotEvent, MascotState> {
  MascotBloc() : super(const MascotInitial(Mascot.empty)) {
    on<MascotEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
