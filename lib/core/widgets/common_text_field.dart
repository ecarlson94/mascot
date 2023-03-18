import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/debouncer.dart';

class CommonTextField extends StatefulWidget {
  final String? labelText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CommonTextField({
    super.key,
    this.labelText,
    this.onChanged,
    this.validator,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final Debouncer _debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderRadius: bigBorderRadius),
        labelText: widget.labelText,
      ),
      onChanged: (value) => _debouncer.run(() => widget.onChanged?.call(value)),
    );
  }
}
