import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../expressions/presentation/widgets/upload_expression.dart';
import '../bloc/create_mascot_bloc.dart';

class NewMascotPage extends StatelessWidget {
  const NewMascotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<CreateMascotBloc>(),
        child: BlocBuilder<CreateMascotBloc, CreateMascotState>(
          builder: (context, state) {
            var bloc = BlocProvider.of<CreateMascotBloc>(context);
            return Center(
              child: ResponsiveRowColumn(
                rowMainAxisAlignment: MainAxisAlignment.center,
                rowPadding: const EdgeInsets.all(30),
                columnPadding: const EdgeInsets.all(30),
                rowSpacing: 30,
                columnSpacing: 30,
                layout: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                children: [
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: UploadExpression(
                      label: 'Upload mascot\'s default expression',
                      defaultImage: state.mascot.expressions
                          .firstWhereOrNull((e) =>
                              e.name == CreateMascotBloc.neutralExpressionName)
                          ?.image,
                      onImageSelected: (image) {
                        bloc.add(UploadNeutralExpression(image));
                      },
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: UploadExpression(
                      label: 'Upload mascot\'s expression for talking',
                      defaultImage: state.mascot.expressions
                          .firstWhereOrNull((e) =>
                              e.name == CreateMascotBloc.talkingExpressionName)
                          ?.image,
                      onImageSelected: (image) {
                        bloc.add(UploadTalkingExpression(image));
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
