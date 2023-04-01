import 'package:flutter/material.dart';

import '../data/drift/mascot_database.dart';
import '../injection/injection_container.dart';

class DatabaseDisposer extends StatefulWidget {
  const DatabaseDisposer({super.key});

  @override
  State<DatabaseDisposer> createState() => _DatabaseDisposerState();
}

class _DatabaseDisposerState extends State<DatabaseDisposer> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  void dispose() {
    getIt<MascotDatabase>().close();
    super.dispose();
  }
}
