import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/clean_architecture/entity.dart';
import '../bloc/settings_bloc.dart';

class FavoriteMascotIdProvider extends StatelessWidget {
  final Widget Function(BuildContext context, Id mascotId) builder;

  const FavoriteMascotIdProvider({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return state.favoriteMascotIdOption.fold(
          () => const SizedBox.shrink(),
          (favoriteMascotId) {
            if (favoriteMascotId == null) {
              return const SizedBox.shrink();
            }

            return builder(context, favoriteMascotId);
          },
        );
      },
    );
  }
}
