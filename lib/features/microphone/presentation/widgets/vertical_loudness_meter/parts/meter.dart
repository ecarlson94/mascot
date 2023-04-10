import 'package:flutter/material.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/utils/constants.dart';

class Meter extends StatelessWidget {
  final double width;
  final double height;
  final double normalizedValue;
  final Widget? child;

  const Meter({
    super.key,
    required this.width,
    required this.height,
    required this.normalizedValue,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      borderRadius: bigBorderRadius,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          _MeterBackground(width: width, height: height),
          _MeterForeground(
            height: height,
            normalizedValue: normalizedValue,
            width: width,
          ),
          if (child != null) child!,
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
      borderRadius: bigBorderRadius,
      clipBehavior: Clip.antiAlias,
      elevation: 3,
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
        borderRadius: bigBorderRadius,
        clipBehavior: Clip.antiAlias,
        elevation: 3,
        child: SizedBox(
          width: width,
          height: height * normalizedValue.clamp(0.0, 1.0),
        ),
      ),
    );
  }
}
