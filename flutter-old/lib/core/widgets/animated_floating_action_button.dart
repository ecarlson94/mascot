import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:mascot/core/extensions/extensions.dart';

import '../utils/constants.dart';

enum _FloatingActionButtonType {
  regular,
  extended,
  small,
}

typedef _FloatingActionButtonBuilder = Widget Function(
  BuildContext context,
  void Function() openContainer,
  Widget child,
  Widget? icon,
);

class AnimatedFloatingActionButton extends StatelessWidget {
  final Widget Function(BuildContext, void Function({void returnValue}))
      openBuilder;
  final Widget child;
  final Widget? icon;
  final Map<_FloatingActionButtonType, _FloatingActionButtonBuilder>
      _fabBuilders = {
    _FloatingActionButtonType.extended: (context, openContainer, child, icon) =>
        FloatingActionButton.extended(
          elevation: 0,
          label: child,
          icon: icon,
          onPressed: openContainer,
        ),
    _FloatingActionButtonType.regular: (context, openContainer, child, icon) =>
        FloatingActionButton(
          elevation: 0,
          onPressed: openContainer,
          child: child,
        ),
    _FloatingActionButtonType.small: (context, openContainer, child, icon) =>
        FloatingActionButton.small(
          elevation: 0,
          onPressed: openContainer,
          child: child,
        ),
  };

  final _FloatingActionButtonType _type;

  AnimatedFloatingActionButton({
    super.key,
    required this.openBuilder,
    required this.child,
  })  : _type = _FloatingActionButtonType.regular,
        icon = null;

  AnimatedFloatingActionButton.extended({
    super.key,
    required this.openBuilder,
    this.icon,
    required Widget label,
  })  : _type = _FloatingActionButtonType.extended,
        child = label;

  AnimatedFloatingActionButton.small({
    super.key,
    required this.openBuilder,
    required this.child,
  })  : _type = _FloatingActionButtonType.small,
        icon = null;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    final FloatingActionButtonThemeData floatingActionButtonTheme =
        theme.floatingActionButtonTheme;
    final shape = floatingActionButtonTheme.shape ??
        const RoundedRectangleBorder(borderRadius: bigBorderRadius);
    final elevation = floatingActionButtonTheme.elevation ?? 6.0;

    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 400),
      tappable: true,
      closedElevation: elevation,
      closedShape: shape,
      closedColor: Colors.transparent,
      openBuilder: openBuilder,
      closedBuilder: (context, openContainer) => _fabBuilders[_type]!(
        context,
        openContainer,
        child,
        icon,
      ),
    );
  }
}
