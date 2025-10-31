part of '../app_theme.dart';

class AppText {
  static TextStyle style({
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    double? lineHeight,
    double? letterSpacing,
    String? fontFamily,
    List<Shadow>? shadows,
    _TextStyleBuilder? fontBuilder,
  }) {
    final height = lineHeight != null ? lineHeight / fontSize : null;
    final letterSpacingPx = letterSpacing?.px;
    if (fontBuilder != null) {
      return fontBuilder(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        letterSpacing: letterSpacingPx,
        shadows: shadows,
      );
    }
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacingPx,
      fontFamily: fontFamily,
      shadows: shadows,
    );
  }

  final TextStyle titleLarge = AppText.style(fontSize: 34);

  final TextStyle title1 = AppText.style(fontSize: 28);

  final TextStyle title2 = AppText.style(fontSize: 22);

  final TextStyle title3 = AppText.style(fontSize: 20);

  final TextStyle headline = AppText.style(fontSize: 17, fontWeight: FontWeight.w600);

  final TextStyle body = AppText.style(fontSize: 17);

  final TextStyle callout = AppText.style(fontSize: 16);

  final TextStyle subhead = AppText.style(fontSize: 15);

  final TextStyle footnote = AppText.style(fontSize: 13);

  final TextStyle caption1 = AppText.style(fontSize: 12);

  final TextStyle caption2 = AppText.style(fontSize: 11);
}

typedef _TextStyleBuilder = TextStyle Function({
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  double? letterSpacing,
  List<Shadow>? shadows,
});

extension PixelExt on double {
  /// Convert letter spacing dạng % trên figma thành dạng pixel trong flutter
  ///
  /// 1 % = 0.16 pixel
  double get px => this * 0.16;
}

extension TextStyleLineHeightExt on TextStyle {
  /// Chiều cao của 1 dòng text
  double get lineHeight => (fontSize ?? 14) * (height ?? 1.2);
}

extension TextStyleFontWeightExt on TextStyle {
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);

  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);

  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);

  TextStyle get black => copyWith(fontWeight: FontWeight.w900);
}

extension TextStyleFontStyleExt on TextStyle {
  TextStyle get italic {
    return copyWith(fontStyle: FontStyle.italic);
  }
}
