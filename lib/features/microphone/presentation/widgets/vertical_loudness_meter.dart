import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/utils/constants.dart';
import 'microphone_volume_provider.dart';

class VerticalLoudnessMeter extends StatefulWidget {
  static const double widthRatio = 1 / 5;
  static const Radius radius = bigRadius;

  final double minDecibels;
  final double maxDecibels;
  final double height;
  final double defaultSliderPositon;
  final void Function(double threshold)? onThresholdChanged;

  const VerticalLoudnessMeter({
    Key? key,
    this.minDecibels = -35,
    this.maxDecibels = 15,
    this.height = 200,
    this.defaultSliderPositon = -10,
    this.onThresholdChanged,
  }) : super(key: key);

  @override
  State<VerticalLoudnessMeter> createState() => _VerticalLoudnessMeterState();
}

class _VerticalLoudnessMeterState extends State<VerticalLoudnessMeter> {
  final ValueNotifier<double?> _sliderPositionNotifier =
      ValueNotifier<double?>(null);

  @override
  void initState() {
    super.initState();
    var sliderPosition = (1 -
            (widget.defaultSliderPositon - widget.minDecibels) /
                (widget.maxDecibels - widget.minDecibels))
        .clamp(0.0, 1.0);

    _sliderPositionNotifier.value = sliderPosition;
  }

  @override
  Widget build(BuildContext context) {
    var buttonPadding = 5.0;
    var maxButtonWidth = 28.0;

    return MicrophoneVolumeProvider(
      builder: (context, volume) {
        return ValueListenableBuilder<double?>(
          valueListenable: _sliderPositionNotifier,
          builder: (context, sliderPosition, _) {
            var width = widget.height * VerticalLoudnessMeter.widthRatio;
            var height = widget.height;
            final double normalizedValue = (volume.value - widget.minDecibels) /
                (widget.maxDecibels - widget.minDecibels);
            sliderPosition = sliderPosition ?? 0.5;

            // TODO: use gesture detector on button and slider, not on whole meter
            return GestureDetector(
              onVerticalDragUpdate: _onDragUpdate,
              onVerticalDragEnd: _onDragEnd,
              child: SizedBox(
                width: width + buttonPadding + maxButtonWidth,
                height: height,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    _Meter(
                      width: width,
                      height: height,
                      normalizedValue: normalizedValue,
                      sliderPosition: sliderPosition,
                      sliderPositionOffset: const Offset(
                          0, -1 * (_SliderButton.maxButtonWidth / 2)),
                      thresholdMet: volume.value >
                          _convertSliderPositionToDecibels(sliderPosition),
                    ),
                    _SliderButton(
                      width: width,
                      height: height,
                      sliderPosition: sliderPosition,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final newValue =
        _sliderPositionNotifier.value! + details.delta.dy / widget.height;
    final newSliderPosition = newValue.clamp(0.0, 1.0);
    final maxSliderPosition =
        (widget.height - (_SliderButton.maxButtonWidth / 2)) / widget.height;
    final minSliderPosition =
        (_SliderButton.maxButtonWidth / 2) / widget.height;
    final clampedSliderPosition =
        newSliderPosition.clamp(minSliderPosition, maxSliderPosition);
    _sliderPositionNotifier.value = clampedSliderPosition;
  }

  void _onDragEnd(DragEndDetails details) {
    widget.onThresholdChanged?.call(
        _convertSliderPositionToDecibels(_sliderPositionNotifier.value!));
  }

  double _convertSliderPositionToDecibels(double sliderPosition) {
    return widget.minDecibels +
        (1 - sliderPosition) * (widget.maxDecibels - widget.minDecibels);
  }
}

class _Meter extends StatelessWidget {
  final double width;
  final double height;
  final double normalizedValue;
  final double sliderPosition;
  final Offset sliderPositionOffset;
  final bool thresholdMet;

  const _Meter({
    required this.width,
    required this.height,
    required this.normalizedValue,
    required this.sliderPosition,
    required this.sliderPositionOffset,
    required this.thresholdMet,
  });

  @override
  Widget build(BuildContext context) {
    var sliderTop = (height * sliderPosition);
    return PhysicalModel(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(VerticalLoudnessMeter.radius.x),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          _MeterBackground(width: width, height: height),
          _MeterForeground(
            height: height,
            normalizedValue: normalizedValue,
            width: width,
          ),
          _ThresholdSlider(
            width: width,
            height: height,
            sliderPosition: sliderPosition,
            thresholdMet: thresholdMet,
            top: sliderTop,
          )
        ],
      ),
    );
  }
}

class _MeterBackground extends StatelessWidget {
  const _MeterBackground({
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: context.colorScheme.tertiaryContainer,
      borderRadius: BorderRadius.circular(VerticalLoudnessMeter.radius.x),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}

class _MeterForeground extends StatelessWidget {
  const _MeterForeground({
    required this.height,
    required this.normalizedValue,
    required this.width,
  });

  final double height;
  final double normalizedValue;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (height * (1 - normalizedValue.clamp(0.0, 1.0))),
      left: 0,
      child: PhysicalModel(
        color: context.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(VerticalLoudnessMeter.radius.x),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: SizedBox(
          width: width,
          height: height * normalizedValue.clamp(0.0, 1.0),
        ),
      ),
    );
  }
}

class _ThresholdSlider extends StatelessWidget {
  final double width;
  final double height;
  final double sliderPosition;
  final bool thresholdMet;
  final double top;

  const _ThresholdSlider({
    required this.width,
    required this.height,
    required this.sliderPosition,
    required this.thresholdMet,
    required this.top,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = context.colorScheme;
    return Positioned(
      top: (sliderPosition * height),
      left: 0,
      child: PhysicalModel(
        color: thresholdMet
            ? colorScheme.onTertiary
            : colorScheme.onTertiaryContainer,
        borderRadius: BorderRadius.circular(2),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: width,
          height: 4, // Slider height
        ),
      ),
    );
  }
}

class _SliderButton extends StatelessWidget {
  static const maxButtonWidth = 28.0;
  static const defaultLeftPadding = 5.0;

  final double width;
  final double height;
  final double sliderPosition;

  const _SliderButton({
    required this.width,
    required this.height,
    required this.sliderPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: width + defaultLeftPadding,
      top: (sliderPosition * height) - (maxButtonWidth / 2),
      child: PhysicalModel(
        elevation: 3, // Resting level 3
        color: context.colorScheme.tertiaryContainer,
        borderRadius:
            BorderRadius.circular(maxButtonWidth / 2), // Button border radius
        child: Container(
          width: maxButtonWidth,
          height: maxButtonWidth,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.record_voice_over,
            size: 18,
            color: context.colorScheme.onTertiaryContainer,
          ),
        ),
      ),
    );
  }
}
