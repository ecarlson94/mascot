import 'package:flutter/material.dart';

import '../../../microphone/presentation/widgets/vertical_loudness_meter.dart';
import 'create_mascot_fab.dart';

class ActionsOverlay extends StatelessWidget {
  const ActionsOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: VerticalLoudnessMeter(),
      floatingActionButton: CreateMascotFab(),
    );
  }
}
