import 'package:flutter/material.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/utils/constants.dart';
import 'microphone_volume_required.dart';

class VerticalLoudnessMeter extends StatelessWidget {
  static const double widthRatio = 1 / 5;
  static const Radius radius = bigRadius;

  final double minDecibels;
  final double maxDecibels;
  final double height;

  const VerticalLoudnessMeter({
    super.key,
    this.minDecibels = -30,
    this.maxDecibels = 20,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return MicrophoneVolumeRequired(
      builder: (context, volume) {
        var colorScheme = context.colorScheme;
        var width = height * widthRatio;
        return CustomPaint(
          painter: _LoudnessMeterPainter(
            decibels: volume.value,
            minDecibels: minDecibels,
            maxDecibels: maxDecibels,
            radius: radius,
            backgroundColor: colorScheme.tertiaryContainer,
            foregroundColor: colorScheme.tertiary,
          ),
          child: SizedBox(
            height: height,
            width: width,
          ),
        );
      },
    );
  }
}

class _LoudnessMeterPainter extends CustomPainter {
  final double decibels;
  final double minDecibels;
  final double maxDecibels;
  final Radius radius;
  final Color? backgroundColor;
  final Color? foregroundColor;

  _LoudnessMeterPainter({
    required this.decibels,
    required this.minDecibels,
    required this.maxDecibels,
    required this.radius,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = backgroundColor ?? Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final foregroundPaint = Paint()
      ..color = foregroundColor ?? Colors.green
      ..style = PaintingStyle.fill;

    final rectBackground =
        RRect.fromLTRBR(0, 0, size.width, size.height, radius);

    double normalizedValue =
        (decibels - minDecibels) / (maxDecibels - minDecibels);
    normalizedValue = normalizedValue.clamp(0.0, 1.0);

    final rectForeground = RRect.fromLTRBR(0,
        size.height * (1 - normalizedValue), size.width, size.height, radius);

    canvas.drawRRect(rectBackground, backgroundPaint);
    canvas.save();
    canvas.clipRRect(rectBackground);
    canvas.drawRRect(rectForeground, foregroundPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _LoudnessMeterPainter oldDelegate) {
    return oldDelegate.decibels != decibels;
  }
}
