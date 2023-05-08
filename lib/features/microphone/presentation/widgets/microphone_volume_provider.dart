import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/extensions.dart';
import '../../domain/models/decibel_lufs.dart';
import '../bloc/microphone_volume/microphone_volume_bloc.dart';

class MicrophoneVolumeProvider extends StatelessWidget {
  final Widget Function(BuildContext, DecibelLufs volume) builder;

  const MicrophoneVolumeProvider({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MicrophoneVolumeBloc, MicrophoneVolumeState>(
      builder: (context, state) {
        if (state is MicrophoneVolumeInitial) {
          context
              .bloc<MicrophoneVolumeBloc>()
              .add(InitializeMicrophoneVolumeEvent());
        }

        return state.volumeOption.fold(
          () => const SizedBox.shrink(),
          (volume) => builder(context, volume),
        );
      },
    );
  }
}
