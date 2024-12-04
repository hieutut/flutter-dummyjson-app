import 'package:flutter/material.dart';

abstract class ThemeColor {
  ThemeColor(this._brightness);

  final Brightness _brightness;
  Brightness get brightness => _brightness;

  Color get primary;
  Color get secondary;

  Color get background;
  Color get screenBackground;
  Color get appBarBackground;
  Color get appBarContent;

  Color get divider;

  Color get text;
  Color get subText;

  Color get success;
  Color get error;
  Color get warning;
}