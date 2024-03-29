import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/injection/injection_container.dart';
import 'core/theme/mascot_themes.dart';
import 'features/actions/presentation/pages/actions_overlay.dart';
import 'features/mascot/presentation/widgets/mascot_underlay.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

Future<void> main() async {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (_) => getIt<SettingsBloc>()..add(LoadSettingsEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'mascot',
        theme: MascotThemes.lightTheme,
        darkTheme: MascotThemes.darkTheme,
        themeMode: ThemeMode.dark,
        builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          minWidth: 400,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
          ],
        ),
        home: Stack(
          children: const [
            MascotUnderlay(),
            ActionsOverlay(),
          ],
        ),
      ),
    );
  }
}
