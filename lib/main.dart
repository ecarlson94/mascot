import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/injection/injection_container.dart';
import 'core/theme/color_schemes.dart';
import 'features/mascot/presentation/widgets/actions_overlay.dart';
import 'features/mascot/presentation/widgets/mascot_underlay.dart';
import 'features/microphone/presentation/bloc/microphone_volume_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';

main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (_) => getIt<SettingsBloc>()..add(LoadSettings()),
      child: BlocProvider(
        create: (context) => getIt<MicrophoneVolumeBloc>(),
        child: MaterialApp(
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
            minWidth: 400,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
            ],
          ),
          home: Stack(children: const [MascotUnderlay(), ActionsOverlay()]),
        ),
      ),
    );
  }
}
