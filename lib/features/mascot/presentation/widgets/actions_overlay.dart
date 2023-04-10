import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../microphone/domain/models/decibel_lufs.dart';
import '../../../microphone/presentation/widgets/vertical_loudness_meter/vertical_loudness_meter.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../settings/presentation/widgets/favorite_mascot_id_provider.dart';
import 'create_mascot_fab.dart';

class ActionsOverlay extends StatelessWidget {
  const ActionsOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 20,
            bottom: 20,
            child: FavoriteMascotIdProvider(
              builder: (_, __) => BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return state.talkingThresholdStreamOption.fold(
                    () => const SizedBox.shrink(),
                    (stream) {
                      return StreamBuilder<DecibelLufs?>(
                        stream: stream,
                        builder: (context, snapshot) {
                          return VerticalLoudnessMeter(
                            sliderThreshold: snapshot.data,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const CreateMascotFab(),
    );
  }
}
