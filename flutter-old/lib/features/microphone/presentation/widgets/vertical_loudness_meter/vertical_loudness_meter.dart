import 'package:flutter/material.dart';

import '../../../../../core/utils/constants.dart';
import '../../../domain/models/decibel_lufs.dart';
import '../microphone_volume_provider.dart';
import 'parts/meter.dart';
import 'parts/slider_button.dart';
import 'parts/vertical_threshold_slider.dart';

class VerticalLoudnessMeter extends StatefulWidget {
  static const double widthRatio = 1 / 5;
  static const Radius radius = bigRadius;
  static const defaultButtonLeftPadding = 5.0;
  static const defaultTalkThreshold = DecibelLufs(-10);

  final double minDecibels;
  final double maxDecibels;
  final double height;
  final DecibelLufs? sliderThreshold;
  final void Function(DecibelLufs threshold)? onThresholdChanged;

  const VerticalLoudnessMeter({
    Key? key,
    this.minDecibels = -35,
    this.maxDecibels = 15,
    this.height = 200,
    this.sliderThreshold,
    this.onThresholdChanged,
  }) : super(key: key);

  @override
  State<VerticalLoudnessMeter> createState() => _VerticalLoudnessMeterState();
}

class _VerticalLoudnessMeterState extends State<VerticalLoudnessMeter> {
  final ValueNotifier<double?> _sliderPositionNotifier =
      ValueNotifier<double?>(null);

  @override
  Widget build(BuildContext context) {
    var buttonPadding = 5.0;
    var maxButtonWidth = 28.0;
    _setSliderPosition();

    return MicrophoneVolumeProvider(
      builder: (context, volume) {
        return ValueListenableBuilder<double?>(
          valueListenable: _sliderPositionNotifier,
          builder: (context, sliderPosition, _) {
            var width = widget.height * VerticalLoudnessMeter.widthRatio;
            var height = widget.height;
            final double normalizedValue = (volume.value - widget.minDecibels) /
                (widget.maxDecibels -
                    widget.minDecibels); // A number between 0.0 - 1.0
            sliderPosition = sliderPosition ?? 0.5;
            var sliderTop = (height * sliderPosition);

            return SizedBox(
              width: width + buttonPadding + maxButtonWidth,
              height: height,
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Meter(
                    width: width,
                    height: height,
                    normalizedValue: normalizedValue,
                    child: Positioned(
                      top: sliderTop,
                      left: 0,
                      child: VerticalThresholdSlider(
                        width: width,
                        thresholdMet: volume.value >
                            _convertSliderPositionToDecibels(sliderPosition)
                                .value,
                        onVerticalDragUpdate: _onDragUpdate,
                        onVerticalDragEnd: _onDragEnd,
                      ),
                    ),
                  ),
                  Positioned(
                    left:
                        width + VerticalLoudnessMeter.defaultButtonLeftPadding,
                    top: (sliderPosition * height) - (maxButtonWidth / 2),
                    child: SliderButton(
                      width: width,
                      height: height,
                      onVerticalDragUpdate: _onDragUpdate,
                      onVerticalDragEnd: _onDragEnd,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _setSliderPosition() {
    var talkingThreshold =
        widget.sliderThreshold ?? VerticalLoudnessMeter.defaultTalkThreshold;
    var sliderPosition = (1 -
            (talkingThreshold.value - widget.minDecibels) /
                (widget.maxDecibels - widget.minDecibels))
        .clamp(0.0, 1.0);

    if (_sliderPositionNotifier.value == sliderPosition) return;
    _sliderPositionNotifier.value = sliderPosition;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final newValue =
        _sliderPositionNotifier.value! + details.delta.dy / widget.height;
    final newSliderPosition = newValue.clamp(0.0, 1.0);

    // Prevent the slider from going off the top or bottom of the meter
    // by calculating the max and min slider positions based on the button size
    final maxSliderPosition =
        (widget.height - (SliderButton.maxButtonWidth / 2)) / widget.height;
    final minSliderPosition = (SliderButton.maxButtonWidth / 2) / widget.height;

    final clampedSliderPosition =
        newSliderPosition.clamp(minSliderPosition, maxSliderPosition);
    _sliderPositionNotifier.value = clampedSliderPosition;
  }

  void _onDragEnd(DragEndDetails details) {
    widget.onThresholdChanged?.call(
        _convertSliderPositionToDecibels(_sliderPositionNotifier.value!));
  }

  DecibelLufs _convertSliderPositionToDecibels(double sliderPosition) {
    return DecibelLufs(
      widget.minDecibels +
          (1 - sliderPosition) * (widget.maxDecibels - widget.minDecibels),
    );
  }
}
