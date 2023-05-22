import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/record_settings.dart';
import '../bloc/settings_bloc.dart';

class RecordSettingsProvider extends StatelessWidget {
  final Widget Function(BuildContext context, RecordSettings recordSettings)
      builder;

  const RecordSettingsProvider({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return state.recordSettingsOption.fold(
        () => const SizedBox.shrink(),
        (recordSettings) => builder(context, recordSettings),
      );
    });
  }
}
