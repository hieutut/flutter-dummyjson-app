part of '../app_theme.dart';

class AppColorsDark extends AppColors {
  AppColorsDark()
      : super(
          primary50: Colors.blue.shade50,
          primary100: Colors.blue.shade100,
          primary200: Colors.blue.shade200,
          primary300: Colors.blue.shade300,
          primary400: Colors.blue.shade400,
          primary500: Colors.blue.shade500,
          primary600: Colors.blue.shade600,
          primary700: Colors.blue.shade700,
          primary800: Colors.blue.shade800,
          primary900: Colors.blue.shade900,
          secondary50: Colors.orange.shade50,
          secondary100: Colors.orange.shade100,
          secondary200: Colors.orange.shade200,
          secondary300: Colors.orange.shade300,
          secondary400: Colors.orange.shade400,
          secondary500: Colors.orange.shade500,
          secondary600: Colors.orange.shade600,
          secondary700: Colors.orange.shade700,
          secondary800: Colors.orange.shade800,
          secondary900: Colors.orange.shade900,
          gray50: Colors.grey.shade50,
          gray100: Colors.grey.shade100,
          gray200: Colors.grey.shade200,
          gray300: Colors.grey.shade300,
          gray400: Colors.grey.shade400,
          gray500: Colors.grey.shade500,
          gray600: Colors.grey.shade600,
          gray700: Colors.grey.shade700,
          gray800: Colors.grey.shade800,
          gray900: Colors.grey.shade900,
        );

  @override
  Color get background => gray900;

  @override
  Color get textPrimary => gray100;
  @override
  Color get textSecondary => gray300;

  @override
  Color get error => Colors.red.shade600;
  @override
  Color get warning => Colors.yellow.shade700;
  @override
  Color get success => Colors.green;
}
