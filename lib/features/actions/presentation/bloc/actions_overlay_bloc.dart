import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'actions_overlay_event.dart';
part 'actions_overlay_state.dart';

@injectable
class ActionsOverlayBloc
    extends Bloc<ActionsOverlayEvent, ActionsOverlayState> {
  ActionsOverlayBloc() : super(const ActionsOverlayInitial()) {
    on<ToggleShowActions>((event, emit) {
      emit(ActionsOverlayChanged(!state.showActions));
    });
  }
}
