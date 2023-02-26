import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/injection/injection_container.dart';
import 'features/images/presentation/bloc/image_bloc.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MASCOT',
      home: Scaffold(
        body: BlocProvider(
          create: (_) => getIt<ImageBloc>(),
          child: const Text('Hello World'),
        ),
      ),
    );
  }
}
