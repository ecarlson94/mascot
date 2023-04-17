import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../mascot/presentation/widgets/create_mascot_fab.dart';
import '../../../microphone/presentation/widgets/vertical_loudness_meter/vertical_loudness_meter.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../settings/presentation/widgets/favorite_mascot_id_provider.dart';
import '../../../settings/presentation/widgets/talking_threshold_provider.dart';
import '../widgets/negative_space_toggle.dart';

class ActionsOverlay extends StatelessWidget {
  const ActionsOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NegativeSpaceToggle(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Positioned(
              left: 20,
              bottom: 20,
              child: FavoriteMascotIdProvider(
                builder: (_, __) => TalkingThresholdProvider(
                  builder: (_, decibels) => VerticalLoudnessMeter(
                    sliderThreshold: decibels,
                    onThresholdChanged: (threshold) => context
                        .bloc<SettingsBloc>()
                        .add(SetTalkingThreshold(threshold)),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: const CreateMascotFab(),
      ),
    );
  }
}
