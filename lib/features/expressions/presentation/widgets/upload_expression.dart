import 'package:flutter/material.dart';

import '../../../../core/widgets/card_button.dart';
import '../../../../core/widgets/reactive_image_picker/reactive_image_picker.dart';

class UploadExpression extends StatelessWidget {
  static const double _defaultWidth = 400;
  static const double _defaultHeight = 300;

  final String label;
  final String formControlName;
  final double width;
  final double height;

  const UploadExpression({
    super.key,
    required this.formControlName,
    this.label = 'Upload expression',
    this.width = _defaultWidth,
    this.height = _defaultHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveImagePicker(
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      formControlName: formControlName,
      inputBuilder: (onPressed) => CardButton(
        onPressed: onPressed,
        child: SizedBox(
          height: height,
          width: width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_photo_alternate_outlined),
                const SizedBox(height: 10),
                Text(label),
              ],
            ),
          ),
        ),
      ),
      imageBuilder: (image, handleDelete, onPressed) => CardButton(
        onPressed: onPressed,
        child: SizedBox(
          height: height,
          width: width,
          child: Image.memory(image.bytes, fit: BoxFit.contain),
        ),
      ),
      popupDialogBuilder: (_) async => ImageSource.gallery,
    );
  }
}
