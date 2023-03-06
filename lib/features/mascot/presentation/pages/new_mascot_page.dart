import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/widgets/common_text_field.dart';
import '../../../expressions/presentation/widgets/upload_expression.dart';
import '../bloc/create_mascot_bloc.dart';

class NewMascotPage extends StatelessWidget {
  const NewMascotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) => getIt<CreateMascotBloc>(),
          child: BlocBuilder<CreateMascotBloc, CreateMascotState>(
            builder: (context, state) {
              var bloc = context.bloc<CreateMascotBloc>();
              const spacing = 20.0;
              return IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ResponsiveRowColumn(
                      rowMainAxisAlignment: MainAxisAlignment.center,
                      rowSpacing: spacing,
                      columnSpacing: spacing,
                      layout: context.responsive.isSmallerThan(DESKTOP)
                          ? ResponsiveRowColumnType.COLUMN
                          : ResponsiveRowColumnType.ROW,
                      children: [
                        ResponsiveRowColumnItem(
                          rowFlex: 1,
                          child: UploadExpression(
                            label: 'Upload mascot\'s default expression',
                            defaultImage: state.mascot.expressions
                                .firstWhereOrNull((e) =>
                                    e.name ==
                                    CreateMascotBloc.neutralExpressionName)
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
                                    e.name ==
                                    CreateMascotBloc.talkingExpressionName)
                                ?.image,
                            onImageSelected: (image) {
                              bloc.add(UploadTalkingExpression(image));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: spacing),
                    CommonTextField(
                      labelText: 'Enter mascot name',
                      onChanged: (value) {
                        bloc.add(SetMascotName(value));
                      },
                    ),
                    const SizedBox(height: spacing),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: context.back,
                        child: const Text('Finish'),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
