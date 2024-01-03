import 'package:flutter/material.dart';

import '../../../../../../core/extensions/extensions.dart';
import '../../../../../../core/widgets/vertical_draggable.dart';

class SliderButton extends StatelessWidget {
  static const maxButtonWidth = 28.0;

  final double width;
  final double height;
  final void Function(DragUpdateDetails details)? onVerticalDragUpdate;
  final void Function(DragEndDetails details)? onVerticalDragEnd;

  const SliderButton({
    super.key,
    required this.width,
    required this.height,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalDraggable(
      onVerticalDragEnd: onVerticalDragEnd,
      onVerticalDragUpdate: onVerticalDragUpdate,
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
