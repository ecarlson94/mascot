import 'package:flutter/material.dart';

import '../../../microphone/presentation/widgets/vertical_loudness_meter/vertical_loudness_meter.dart';
import '../../../settings/presentation/widgets/favorite_mascot_id_provider.dart';
import 'create_mascot_fab.dart';

class ActionsOverlay extends StatelessWidget {
  const ActionsOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FavoriteMascotIdProvider(
        builder: (_, __) => const VerticalLoudnessMeter(),
      ),
      floatingActionButton: const CreateMascotFab(),
    );
  }
}
