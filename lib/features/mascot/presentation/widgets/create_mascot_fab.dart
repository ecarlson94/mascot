import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../pages/new_mascot_page.dart';

class CreateMascotFab extends StatelessWidget {
  const CreateMascotFab({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FloatingActionButtonThemeData floatingActionButtonTheme =
        theme.floatingActionButtonTheme;
    final shape = floatingActionButtonTheme.shape ??
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(28.0)),
        );
    final elevation = floatingActionButtonTheme.elevation ?? 6.0;

    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 400),
      tappable: true,
      closedElevation: elevation,
      closedShape: shape,
      openBuilder: (context, _) => const NewMascotPage(),
      closedBuilder: (context, openContainer) => FloatingActionButton.extended(
        label: const Text('Add mascot'),
        icon: const Icon(Icons.add),
        onPressed: openContainer,
      ),
    );
  }
}
