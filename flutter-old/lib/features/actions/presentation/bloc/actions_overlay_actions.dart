import 'actions_overlay_bloc.dart';

ActionsOverlayState toggleActionsOverlay(
  ToggleShowActionsEvent event,
  ActionsOverlayState state,
) =>
    ActionsOverlayState(!state.showActions);
