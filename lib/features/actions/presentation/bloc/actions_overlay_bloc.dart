import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/reactive/base_bloc.dart';
import 'actions_overlay_actions.dart' as actions;

part 'actions_overlay_event.dart';
part 'actions_overlay_state.dart';

@injectable
class ActionsOverlayBloc
    extends BaseBloc<ActionsOverlayEvent, ActionsOverlayState> {
  ActionsOverlayBloc() : super(const ActionsOverlayInitial()) {
    createAction(actions.toggleActionsOverlay);
  }
}
