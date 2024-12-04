import 'package:flutter/material.dart';

import 'core_image.dart';

class CoreIcon extends CoreImage {
  const CoreIcon(
    super.source, {
    super.key,
    super.width,
    super.height,
    super.size = 24,
    super.fit = BoxFit.contain,
    super.color,
    super.maxWidthDiskCache,
    super.errorWidget,
    super.heroTag,
    super.placeholderIconSize,
    super.onTap,
    super.borderRadius = BorderRadius.zero,
    super.shape = BoxShape.circle,
  });
}
