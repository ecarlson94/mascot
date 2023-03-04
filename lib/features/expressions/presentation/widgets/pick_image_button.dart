import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/expression_bloc.dart';

class PickImageButton extends StatelessWidget {
  const PickImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpressionBloc, ExpressionState>(
      builder: (context, state) {
        var imageBloc = BlocProvider.of<ExpressionBloc>(context);
        var isSaving = state is SavingExpression;
        return FilledButton(
          onPressed: isSaving
              ? null
              : () async {
                  final ImagePicker picker = ImagePicker();
                  var image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    imageBloc.add(SaveExpressionEvent(
                      name: 'testname',
                      description: 'test description',
                      image: image,
                    ));
                  }
                },
          child: const Text('PICK'),
        );
      },
    );
  }
}
