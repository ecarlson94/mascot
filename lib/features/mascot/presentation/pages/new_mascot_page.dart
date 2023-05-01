import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/widgets/common_text_field.dart';
import '../../../expressions/presentation/widgets/upload_expression.dart';
import '../bloc/create_mascot/create_mascot_bloc.dart';

class NewMascotPage extends StatelessWidget {
  const NewMascotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) =>
              getIt<CreateMascotBloc>()..add(InitializeEvent()),
          child: BlocBuilder<CreateMascotBloc, CreateMascotState>(
            builder: (context, state) {
              var isSaving = state is SavingMascot;
              if (state is MascotSaved) {
                SchedulerBinding.instance
                    .addPostFrameCallback((_) => context.back());
              }

              return state.form.fold(
                () => const SizedBox.shrink(),
                (form) {
                  var bloc = context.bloc<CreateMascotBloc>();
                  const spacing = 20.0;
                  return ReactiveForm(
                    formGroup: form,
                    child: IntrinsicWidth(
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
                            children: const [
                              ResponsiveRowColumnItem(
                                rowFlex: 1,
                                child: UploadExpression(
                                  formControlName: CreateMascotBloc
                                      .neutralExpressionFormControlName,
                                  label: 'Upload mascot\'s default expression',
                                ),
                              ),
                              ResponsiveRowColumnItem(
                                rowFlex: 1,
                                child: UploadExpression(
                                  formControlName: CreateMascotBloc
                                      .talkingExpressionFormControlName,
                                  label:
                                      'Upload mascot\'s expression for talking',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: spacing),
                          const CommonTextField(
                            formControlName:
                                CreateMascotBloc.nameFormControlName,
                            labelText: 'Enter mascot name',
                          ),
                          const SizedBox(height: spacing),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: isSaving
                                  ? null
                                  : () => form.valid
                                      ? bloc.add(SaveMascot())
                                      : form.markAllAsTouched(),
                              child: isSaving
                                  ? const CircularProgressIndicator()
                                  : const Text('Save'),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
