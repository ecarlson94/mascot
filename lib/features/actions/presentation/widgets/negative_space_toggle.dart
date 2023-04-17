import 'package:flutter/material.dart';

class NegativeSpaceToggle extends StatefulWidget {
  final Widget? child;

  const NegativeSpaceToggle({super.key, this.child});

  @override
  State<NegativeSpaceToggle> createState() => _NegativeSpaceToggleState();
}

class _NegativeSpaceToggleState extends State<NegativeSpaceToggle> {
  bool _showChild = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _showChild = !_showChild),
      child: _showChild
          ? widget.child!
          : const Scaffold(
              backgroundColor: Colors.transparent,
              body: SizedBox.expand(),
            ),
    );
  }
}
