import 'package:flutter/material.dart';

import '../../../../../../core/extensions/extensions.dart';

class VerticalThresholdSlider extends StatelessWidget {
  final double width;
  final bool thresholdMet;
  final void Function(DragUpdateDetails details)? onVerticalDragUpdate;
  final void Function(DragEndDetails details)? onVerticalDragEnd;

  const VerticalThresholdSlider({
    super.key,
    required this.width,
    required this.thresholdMet,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = context.colorScheme;
    return Stack(
      children: [
        PhysicalModel(
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
        Align(
          alignment: Alignment.center,
          child: Container(
            width: width,
            height: 16,
            color: Colors.transparent,
            child: GestureDetector(
              onVerticalDragUpdate: onVerticalDragUpdate,
              onVerticalDragEnd: onVerticalDragEnd,
            ),
          ),
        )
      ],
    );
  }
}
