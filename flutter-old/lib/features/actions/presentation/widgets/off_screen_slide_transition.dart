import 'package:flutter/material.dart';

enum OffScreenSlideDirection {
  left,
  right,
  top,
  bottom,
  bottomLeft,
  bottomRight,
  topLeft,
  topRight,
}

class OffScreenSlideTransition extends StatefulWidget {
  final OffScreenSlideDirection direction;
  final Widget? child;
  final bool reverse;

  const OffScreenSlideTransition({
    Key? key,
    this.direction = OffScreenSlideDirection.bottom,
    this.child,
    this.reverse = false,
  }) : super(key: key);

  @override
  State<OffScreenSlideTransition> createState() =>
      _OffScreenSlideTransitionState();
}

class _OffScreenSlideTransitionState extends State<OffScreenSlideTransition>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: _offsetForDirection(widget.direction),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.reverse) {
          _animationController.reverse();
        }
      } else if (status == AnimationStatus.dismissed) {
        if (!widget.reverse) {
          _animationController.forward();
        }
      }
    });

    // Start the animation
    widget.reverse
        ? _animationController.reverse()
        : _animationController.forward();
  }

  @override
  void didUpdateWidget(OffScreenSlideTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reverse != widget.reverse) {
      widget.reverse
          ? _animationController.reverse()
          : _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Offset _offsetForDirection(OffScreenSlideDirection direction) {
    switch (direction) {
      case OffScreenSlideDirection.left:
        return const Offset(-1.0, 0.0);
      case OffScreenSlideDirection.right:
        return const Offset(1.0, 0.0);
      case OffScreenSlideDirection.top:
        return const Offset(0.0, -1.0);
      case OffScreenSlideDirection.bottom:
        return const Offset(0.0, 1.0);
      case OffScreenSlideDirection.bottomLeft:
        return const Offset(-1.0, 1.0);
      case OffScreenSlideDirection.bottomRight:
        return const Offset(1.5, 1.0);
      case OffScreenSlideDirection.topLeft:
        return const Offset(-1.0, -1.0);
      case OffScreenSlideDirection.topRight:
        return const Offset(1.3, -1.3);
    }
  }
}
