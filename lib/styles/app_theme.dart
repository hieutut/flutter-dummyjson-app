import 'package:flutter/material.dart';

part 'app_theme_extension.dart';
part 'colors/app_colors.dark.dart';
part 'colors/app_colors.dart';
part 'colors/app_colors.light.dart';
part 'text/app_text.dart';

class AppTheme {
  static final AppColors _light = AppColorsLight();
  static final AppColors _dark = AppColorsDark();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: _light.background,
    primaryColor: _light.primary,
    colorScheme: ColorScheme.light(
      primary: _light.primary,
      secondary: _light.secondary,
      surface: _light.background,
      error: _light.error,
    ),
    extensions: [AppThemeExtension(colors: _light)],
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _dark.background,
    primaryColor: _dark.primary,
    colorScheme: ColorScheme.dark(
      primary: _dark.primary,
      secondary: _dark.secondary,
      surface: _dark.background,
      error: _dark.error,
    ),
    extensions: [AppThemeExtension(colors: _dark)],
  );
}
