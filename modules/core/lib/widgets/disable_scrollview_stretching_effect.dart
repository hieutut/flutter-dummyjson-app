import 'package:flutter/material.dart';

class DisableScrollViewStretchingEffect extends StatelessWidget {
  /// Từ flutter 3.16 trở lên thì mặc định có hiệu ứng stretching khi scrollview được scroll đến điểm overscroll.
  /// Nhưng hiệu ứng này chưa ổn định và còn gây bug lỗi giao diện bị giãn ra và đơ.
  ///
  /// Dùng widget này bọc bên ngoài scrollview để disable hiệu ứng stretching đó.
  const DisableScrollViewStretchingEffect({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: child,
    );
  }
}
