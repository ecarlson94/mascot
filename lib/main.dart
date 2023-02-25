import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/dependency_injection/injection_container.dart';
import 'features/images/presentation/bloc/image_bloc.dart';
import 'features/images/presentation/widgets/pick_image_button.dart';

void main() {
  configureDependencies();
  runApp(
    FutureBuilder(
      future: getIt.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return const MyApp();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ),
  );
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
          child: const PickImageButton(),
        ),
      ),
    );
  }
}
