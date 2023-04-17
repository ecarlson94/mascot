part of 'actions_overlay_bloc.dart';

abstract class ActionsOverlayState extends Equatable {
  final bool showActions;

  const ActionsOverlayState(this.showActions);

  @override
  List<Object?> get props => [showActions];
}

class ActionsOverlayInitial extends ActionsOverlayState {
  const ActionsOverlayInitial() : super(true);
}

class ActionsOverlayChanged extends ActionsOverlayState {
  const ActionsOverlayChanged(bool showActions) : super(showActions);
}
