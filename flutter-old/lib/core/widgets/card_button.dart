import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CardButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;

  const CardButton({super.key, this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: mediumBorderRadius,
        ),
      ),
      child: child,
    );
  }
}
