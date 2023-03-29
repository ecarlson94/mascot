import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

import '../../../../core/widgets/card_button.dart';

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
          child: _ImageView(image: image),
        ),
      ),
    );
  }
}

class _ImageView extends StatelessWidget {
  final ImageFile image;

  const _ImageView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localImage = image.localImage;
    if (localImage != null) {
      final file = File(localImage);
      return Image.memory(file.readAsBytesSync(), fit: BoxFit.contain);
    }

    final imageUrl = image.imageUrl;
    if (imageUrl != null) {
      return Image.network(imageUrl, fit: BoxFit.contain);
    }

    final imageFile = image.image;
    if (imageFile != null) {
      return Image.file(imageFile, fit: BoxFit.contain);
    }

    return const SizedBox.shrink();
  }
}
