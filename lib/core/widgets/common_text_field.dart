import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../utils/constants.dart';

class CommonTextField extends StatelessWidget {
  final String? labelText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String formControlName;

  const CommonTextField({
    super.key,
    required this.formControlName,
    this.labelText,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: formControlName,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderRadius: bigBorderRadius),
        labelText: labelText,
      ),
    );
  }
}
