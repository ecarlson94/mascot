import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/image_bloc.dart';

class PickImageButton extends StatelessWidget {
  const PickImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      builder: (context, state) {
        var imageBloc = BlocProvider.of<ImageBloc>(context);
        var isSaving = state is SavingImage;
        return FilledButton(
          onPressed: isSaving
              ? null
              : () async {
                  final ImagePicker picker = ImagePicker();
                  var image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    imageBloc.add(SaveImageEvent(image: image));
                  }
                },
          child: const Text('PICK'),
        );
      },
    );
  }
}
