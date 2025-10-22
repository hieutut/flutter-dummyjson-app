part of 'app_theme.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final AppColors colors;
  final AppText text;

  AppThemeExtension({
    required this.colors,
  }) : text = AppText();

  @override
  AppThemeExtension copyWith({AppColors? colors}) {
    return AppThemeExtension(colors: colors ?? this.colors);
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return this;
  }
}

extension AppThemeContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppThemeExtension>()!.colors;
  AppText get text => Theme.of(this).extension<AppThemeExtension>()!.text;
}
