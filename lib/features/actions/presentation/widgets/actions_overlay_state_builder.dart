import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection_container.dart';
import '../bloc/actions_overlay_bloc.dart';

class ActionsOverlayStateBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ActionsOverlayState state)
      builder;

  const ActionsOverlayStateBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActionsOverlayBloc>(
      create: (_) => getIt<ActionsOverlayBloc>(),
      child: BlocBuilder<ActionsOverlayBloc, ActionsOverlayState>(
        builder: builder,
      ),
    );
  }
}
