part of 'actions_overlay_bloc.dart';

abstract class ActionsOverlayEvent extends Equatable {
  const ActionsOverlayEvent();

  @override
  List<Object?> get props => [];
}

class ToggleShowActions extends ActionsOverlayEvent {}
