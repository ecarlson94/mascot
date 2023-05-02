import 'actions_overlay_bloc.dart';

ActionsOverlayState toggleActionsOverlay(
  ToggleShowActions event,
  ActionsOverlayState state,
) =>
    ActionsOverlayState(!state.showActions);
