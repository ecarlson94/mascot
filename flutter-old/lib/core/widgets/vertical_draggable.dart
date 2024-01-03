import 'package:flutter/material.dart';

class VerticalDraggable extends StatefulWidget {
  final void Function(DragUpdateDetails details)? onVerticalDragUpdate;
  final void Function(DragEndDetails details)? onVerticalDragEnd;
  final Widget? child;

  const VerticalDraggable({
    super.key,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.child,
  });

  @override
  State<VerticalDraggable> createState() => _VerticalDraggableState();
}

class _VerticalDraggableState extends State<VerticalDraggable> {
  bool _isGrabbing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (_) => setState(() => _isGrabbing = true),
      onVerticalDragUpdate: widget.onVerticalDragUpdate,
      onVerticalDragEnd: (details) {
        setState(() => _isGrabbing = false);
        widget.onVerticalDragEnd?.call(details);
      },
      child: MouseRegion(
        cursor:
            _isGrabbing ? SystemMouseCursors.grabbing : SystemMouseCursors.grab,
        child: widget.child,
      ),
    );
  }
}
