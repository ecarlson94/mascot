import 'package:flutter/material.dart';

import 'create_mascot_fab.dart';

class ActionsOverlay extends StatelessWidget {
  const ActionsOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.shrink(),
      floatingActionButton: CreateMascotFab(),
    );
  }
}
