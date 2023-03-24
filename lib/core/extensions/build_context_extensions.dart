import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension BuildContextExtensions on BuildContext {
  T bloc<T extends StateStreamableSource<Object?>>() =>
      BlocProvider.of<T>(this);

  ResponsiveWrapperData get responsive => ResponsiveWrapper.of(this);

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  void back() => Navigator.of(this).pop();
}
