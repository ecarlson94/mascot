import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'color_schemes.dart';

class MascotThemes {
  static ThemeData lightTheme = ThemeData(
    colorScheme: lightColorScheme,
    useMaterial3: true,
    cardTheme: _cardTheme,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: darkColorScheme,
    useMaterial3: true,
    cardTheme: _cardTheme,
  );

  static CardTheme get _cardTheme => const CardTheme(
        shape: RoundedRectangleBorder(borderRadius: mediumBorderRadius),
      );
}
