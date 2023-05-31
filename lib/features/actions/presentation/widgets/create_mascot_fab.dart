import 'package:flutter/material.dart';
import 'package:mascot/core/widgets/animated_floating_action_button.dart';

import '../../../mascot/presentation/pages/new_mascot_page.dart';

class CreateMascotFab extends StatelessWidget {
  const CreateMascotFab({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingActionButton.extended(
      openBuilder: (context, _) => const NewMascotPage(),
      label: const Text('Add mascot'),
      icon: const Icon(Icons.add),
    );
  }
}
