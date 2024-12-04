import 'package:flutter/material.dart';

import '../theme_color.dart';

class ThemeColorLight extends ThemeColor {
  ThemeColorLight() : super(Brightness.light);

  @override
  Color get primary => Colors.blue;
  @override
  Color get secondary => Colors.orange;

  @override
  Color get background => Colors.white;
  @override
  Color get screenBackground => Colors.grey.shade100;
  @override
  Color get appBarBackground => primary;
  @override
  Color get appBarContent => Colors.white;

  @override
  Color get divider => Colors.grey.shade300;

  @override
  Color get text => Colors.grey.shade900;
  @override
  Color get subText => Colors.grey;

  @override
  Color get success => Colors.green;
  @override
  Color get error => Colors.red.shade600;
  @override
  Color get warning => Colors.yellow.shade700;
}
