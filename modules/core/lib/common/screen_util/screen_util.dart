import 'package:flutter/material.dart';

class ScreenUtil {
  ScreenUtil._();

  static final ScreenUtil _instance = ScreenUtil._();
  static ScreenUtil get instance => _instance;

  MediaQueryData _data = const MediaQueryData();
  MediaQueryData get data => _data;

  Size _size = const Size(0, 0);
  Size get size => _size;

  double _width = 0;
  double get width => _width;

  double _height = 0;
  double get height => _height;

  EdgeInsets _padding = EdgeInsets.zero;
  EdgeInsets get padding => _padding;

  double _devicePixelRatio = 0;
  double get devicePixelRatio => _devicePixelRatio;

  /// Chiều cao thanh status bar của device (thanh hiển thị ngày tháng, giờ, phần trăm pin, vạch sóng,...)
  double get statusBarHeight => _statusBarHeight;
  double _statusBarHeight = 0;

  /// Chiều cao thanh điều hướng của device (thanh hiển thị nút Home, nút Back, nút Recent...)
  double get deviceNavigationBarHeight => _deviceNavigationBarHeight;
  double _deviceNavigationBarHeight = 0;

  void setup(BuildContext context) {
    _data = MediaQuery.of(context);
    _size = _data.size;
    _width = size.width;
    _height = size.height;
    _padding = _data.padding;
    _devicePixelRatio = _data.devicePixelRatio;

    final mediaQueryFromView = MediaQueryData.fromView(View.of(context));
    _statusBarHeight = mediaQueryFromView.padding.top;
    _deviceNavigationBarHeight = mediaQueryFromView.padding.bottom;
  }

  bool get isTablet => size.shortestSide >= 600;
}
