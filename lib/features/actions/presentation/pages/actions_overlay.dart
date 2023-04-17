import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../mascot/presentation/widgets/create_mascot_fab.dart';
import '../../../microphone/presentation/widgets/vertical_loudness_meter/vertical_loudness_meter.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../settings/presentation/widgets/favorite_mascot_id_provider.dart';
import '../../../settings/presentation/widgets/talking_threshold_provider.dart';
import '../bloc/actions_overlay_bloc.dart';
import '../widgets/actions_overlay_state_builder.dart';
import '../widgets/off_screen_slide_transition.dart';

class ActionsOverlay extends StatelessWidget {
  const ActionsOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const actionPadding = 20.0;
    return ActionsOverlayStateBuilder(
      builder: (context, state) {
        var bloc = context.bloc<ActionsOverlayBloc>();
        return GestureDetector(
          onTap: () => bloc.add(ToggleShowActions()),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Positioned(
                  left: actionPadding,
                  bottom: actionPadding,
                  child: FavoriteMascotIdProvider(
                    builder: (_, __) => TalkingThresholdProvider(
                      builder: (_, decibels) => OffScreenSlideTransition(
                        reverse: !state.showActions,
                        direction: OffScreenSlideDirection.bottomLeft,
                        child: VerticalLoudnessMeter(
                          sliderThreshold: decibels,
                          onThresholdChanged: (threshold) => context
                              .bloc<SettingsBloc>()
                              .add(SetTalkingThreshold(threshold)),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: actionPadding,
                  right: actionPadding,
                  child: OffScreenSlideTransition(
                    reverse: !state.showActions,
                    direction: OffScreenSlideDirection.bottomRight,
                    child: const CreateMascotFab(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
