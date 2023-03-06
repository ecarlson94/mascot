import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/injection/injection_container.dart';
import 'core/theme/color_schemes.dart';
import 'features/mascot/presentation/widgets/create_mascot_fab.dart';

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
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(450, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
        ],
      ),
      home: const Scaffold(
        body: Center(
          child: SizedBox.shrink(),
        ),
        floatingActionButton: CreateMascotFab(),
      ),
    );
  }
}
