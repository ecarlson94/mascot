import 'package:flutter/material.dart';

class PickImageButton extends StatelessWidget {
  const PickImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: make extended on desktop
    return FloatingActionButton.large(
      onPressed: () {},
      child: const Icon(Icons.add),
    );
  }
}
