import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../settings/presentation/widgets/favorite_mascot_id_provider.dart';
import '../bloc/mascot_animator/mascot_animator_bloc.dart';

class MascotUnderlay extends StatelessWidget {
  const MascotUnderlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FavoriteMascotIdProvider(
          builder: (context, mascotId) => BlocProvider<MascotAnimatorBloc>(
            create: (_) =>
                getIt<MascotAnimatorBloc>()..add(LoadMascotEvent(mascotId)),
            child: BlocBuilder<MascotAnimatorBloc, MascotAnimatorState>(
              builder: (context, state) {
                return state.expressionOption.fold(
                  () => const CircularProgressIndicator(),
                  (expression) {
                    return Image.memory(
                      expression.image,
                      fit: BoxFit.contain,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
