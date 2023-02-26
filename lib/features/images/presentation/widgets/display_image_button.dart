import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/image_bloc.dart';

class DisplayImage extends StatelessWidget {
  const DisplayImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      builder: (context, state) {
        return state is ImageLoaded
            ? Image.memory(state.image.data)
            : const Placeholder();
      },
    );
  }
}
