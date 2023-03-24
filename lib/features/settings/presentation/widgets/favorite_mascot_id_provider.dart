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
        return state.favoriteMascotIdStreamOption.fold(
          () => const SizedBox.shrink(),
          (favoriteMascotIdStream) => StreamBuilder<int?>(
            stream: favoriteMascotIdStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const SizedBox.shrink();
              }

              return builder(context, snapshot.data!);
            },
          ),
        );
      },
    );
  }
}
