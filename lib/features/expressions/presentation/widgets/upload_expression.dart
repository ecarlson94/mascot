import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/image.dart' as model;

class UploadExpression extends StatelessWidget {
  static const double _defaultWidth = 400;
  static const double _defaultHeight = 300;

  final String label;
  final model.Image? defaultImage;
  final Function(XFile)? onImageSelected;
  final double width;
  final double height;

  const UploadExpression({
    super.key,
    this.label = 'Upload expression',
    this.defaultImage,
    this.onImageSelected,
    this.width = _defaultWidth,
    this.height = _defaultHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        var image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) onImageSelected?.call(image);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            height: height,
            width: width,
            child: defaultImage == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_photo_alternate_outlined),
                        const SizedBox(height: 10),
                        Text(label),
                      ],
                    ),
                  )
                : Image.memory(
                    defaultImage!.data,
                    fit: BoxFit.contain,
                  ),
          ),
        ),
      ),
    );
  }
}
