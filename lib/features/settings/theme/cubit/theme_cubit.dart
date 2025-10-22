import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'theme_state.dart';

@Singleton()
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(
          ThemeState.fromBrightness(
            brightness: WidgetsBinding.instance.platformDispatcher.platformBrightness,
          ),
        );

  void toggleTheme() {
    emit(
      state.copyWith(
        themeMode: state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
