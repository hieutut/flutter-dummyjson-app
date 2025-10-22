// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({
    this.themeMode = ThemeMode.system,
  });

  factory ThemeState.fromBrightness({required Brightness brightness}) {
    return ThemeState(
      themeMode: brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  ThemeState copyWith({
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
      ];
}

extension ThemeModeExt on ThemeMode {
  bool get isDark => this == ThemeMode.dark;
  bool get isLight => this == ThemeMode.light;

  String get title {
    switch (this) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light mode';
      case ThemeMode.dark:
        return 'Dark mode';
    }
  }
}
