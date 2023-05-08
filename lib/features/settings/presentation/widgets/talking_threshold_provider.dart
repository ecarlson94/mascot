import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../microphone/domain/models/decibel_lufs.dart';
import '../bloc/settings_bloc.dart';

class TalkingThresholdProvider extends StatelessWidget {
  final Widget Function(BuildContext context, DecibelLufs decibels) builder;

  const TalkingThresholdProvider({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return state.talkingThresholdOption.fold(
          () => const SizedBox.shrink(),
          (talkingThreshold) {
            if (talkingThreshold == null) {
              return const SizedBox.shrink();
            }

            return builder(context, talkingThreshold);
          },
        );
      },
    );
  }
}
