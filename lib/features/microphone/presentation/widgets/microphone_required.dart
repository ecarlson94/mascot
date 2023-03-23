import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/extensions.dart';
import '../../domain/models/decibel_lufs.dart';
import '../bloc/microphone_volume_bloc.dart';

class MicrophoneVolumeRequired extends StatelessWidget {
  final Widget Function(BuildContext, DecibelLufs volume) builder;

  const MicrophoneVolumeRequired({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MicrophoneVolumeBloc, MicrophoneVolumeState>(
      builder: (context, state) {
        if (state is MicrophoneVolumeInitial) {
          context
              .bloc<MicrophoneVolumeBloc>()
              .add(InitializeMicrophoneVolume());
        }

        return state.volumeStreamOption.fold(
          () => const SizedBox.shrink(),
          (volumeStream) => StreamBuilder<DecibelLufs>(
            stream: volumeStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }

              return builder(context, snapshot.data!);
            },
          ),
        );
      },
    );
  }
}
