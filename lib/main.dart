import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/injection/injection_container.dart';
import 'features/expressions/presentation/bloc/expression_bloc.dart';
import 'features/expressions/presentation/widgets/display_image.dart';
import 'features/expressions/presentation/widgets/pick_image_button.dart';

Future main() async {
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mascot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        maxWidth: double.infinity,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
        ],
      ),
      home: Scaffold(
        body: BlocProvider(
          create: (_) => getIt<ExpressionBloc>(),
          child: Center(
            child: Column(children: const [
              PickImageButton(),
              DisplayImage(),
            ]),
          ),
        ),
      ),
    );
  }
}
