import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core.dart';

typedef ImageErrorWidgetBuilder = Widget Function(
  BuildContext context,
  String url,
  Object error,
  StackTrace? stacktrace,
);

class CoreImage extends StatelessWidget {
  const CoreImage(
    this.source, {
    super.key,
    this.width,
    this.height,
    this.size,
    this.fit = BoxFit.cover,
    this.color,
    this.maxWidthDiskCache,
    this.errorWidget,
    this.heroTag,
    this.placeholderIconSize,
    this.onTap,
    this.borderRadius = BorderRadius.zero,
    this.shape = BoxShape.rectangle,
  });

  final String source;
  final double? width;
  final double? height;
  final double? size;
  final BoxFit fit;
  final Color? color;
  final int? maxWidthDiskCache; // maximum width of the image to cache on disk
  final ImageErrorWidgetBuilder? errorWidget;
  final String? heroTag;
  final double? placeholderIconSize;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final double? w = size ?? width;
    final double? h = size ?? height;

    final bool isSvg = source.toLowerCase().endsWith('.svg');

    Widget imageWidget;

    //! SVG
    if (isSvg) {
      //! Network SVG
      if (source.isHttpUrl) {
        imageWidget = SvgPicture.network(
          source,
          width: w,
          height: h,
          fit: fit,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      }
      //! File SVG
      else if (source.isLocalPath) {
        imageWidget = SvgPicture.file(
          File(source),
          width: w,
          height: h,
          fit: fit,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      }
      //! Asset SVG
      else {
        imageWidget = SvgPicture.asset(
          source,
          width: w,
          height: h,
          fit: fit,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      }
    }
    //! Normal image
    else {
      //! Network image
      if (source.isHttpUrl) {
        imageWidget = CachedNetworkImage(
          imageUrl: source,
          width: w,
          height: h,
          fit: fit,
          maxWidthDiskCache: maxWidthDiskCache,
          placeholder: (context, url) => Container(
            width: w,
            height: h,
            color: Colors.grey.shade200,
          ),
          errorWidget: (BuildContext context, String url, Object error) {
            if (errorWidget != null) {
              return errorWidget!(context, url, error, null);
            }
            return _ErrorWidgetDefault(size: placeholderIconSize);
          },
        );
      }
      //! File image
      else if (source.isLocalPath) {
        imageWidget = Image.file(
          File(source),
          width: w,
          height: h,
          fit: fit,
          color: color,
          errorBuilder: (context, error, stackTrace) {
            if (errorWidget != null) {
              return errorWidget!(context, source, error, stackTrace);
            }
            return _ErrorWidgetDefault(size: placeholderIconSize);
          },
        );
      }
      //! Asset image
      else {
        imageWidget = Image.asset(
          source,
          width: w,
          height: h,
          fit: fit,
          color: color,
          errorBuilder: (context, error, stackTrace) {
            if (errorWidget != null) {
              return errorWidget!(context, source, error, stackTrace);
            }
            return _ErrorWidgetDefault(size: placeholderIconSize);
          },
        );
      }
    }

    //! Hero animation
    if (heroTag.isNotEmptyOrNull) {
      imageWidget = Hero(tag: heroTag!, child: imageWidget);
    }

    //! Handle onTap or view image in full screen (only for network or asset image)
    if (onTap != null) {
      imageWidget = GestureDetector(
        onTap: onTap,
        child: imageWidget,
      );
    }

    //! Clip image
    if (shape == BoxShape.circle) {
      imageWidget = ClipOval(child: imageWidget);
    } else if (borderRadius != BorderRadius.zero) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}

class _ErrorWidgetDefault extends StatelessWidget {
  const _ErrorWidgetDefault({
    double? size,
  }) : size = size ?? 30;

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo,
            color: Colors.grey.shade400,
            size: size,
          ),
          const Text('not available'),
        ],
      ),
    );
  }
}
