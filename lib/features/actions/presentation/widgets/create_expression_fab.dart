import 'package:flutter/material.dart';
import 'package:mascot/core/widgets/animated_floating_action_button.dart';

import '../../../expressions/presentation/pages/create_expression_page.dart';

class CreateExpressionFab extends StatelessWidget {
  const CreateExpressionFab({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingActionButton.small(
      openBuilder: (context, _) => const CreateExpressionPage(),
      child: const Icon(Icons.add_reaction),
    );
  }
}
