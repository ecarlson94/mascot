import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/expression_bloc.dart';

class DisplayImage extends StatelessWidget {
  const DisplayImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpressionBloc, ExpressionState>(
      builder: (context, state) {
        return state is ExpressionLoaded
            ? Image.memory(state.expression.image.data)
            : const SizedBox.shrink();
      },
    );
  }
}
