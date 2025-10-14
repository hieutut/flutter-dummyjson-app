import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/metric_constants.dart';

class ProductImagesWidget extends StatefulWidget {
  const ProductImagesWidget({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  State<ProductImagesWidget> createState() => _ProductImagesWidgetState();
}

class _ProductImagesWidgetState extends State<ProductImagesWidget> {
  static const double IMAGE_SIZE = 50;

  late final List<String> images;

  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    images = widget.images;
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox.square(
          dimension: ScreenUtil.instance.width,
          child: PageView.builder(
            controller: pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              scrollController.animateTo(
                index * (IMAGE_SIZE + kSpaceItem),
                duration: Durations.short4,
                curve: Curves.linear,
              );
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return CoreImage(
                images[index],
                size: ScreenUtil.instance.width,
              );
            },
          ),
        ),
        SizedBox(
          height: IMAGE_SIZE + kPadding16All.vertical,
          child: ListView.separated(
            controller: scrollController,
            itemCount: images.length,
            padding: kPadding16All,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            separatorBuilder: (context, index) => kBoxSpaceItem,
            itemBuilder: (context, index) {
              final String img = images[index];
              final bool isSelected = index == currentIndex;
              return InkWell(
                borderRadius: kBorderRadius12,
                onTap: () {
                  if (!isSelected) {
                    pageController.jumpToPage(index);
                  }
                },
                child: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    color: isSelected ? null : Colors.white.withValues(alpha: 0.4),
                    borderRadius: kBorderRadius12,
                    border: Border.all(
                      width: isSelected ? 1.5 : 1,
                      color: Colors.black26,
                    ),
                  ),
                  child: CoreImage(
                    img,
                    size: IMAGE_SIZE,
                    borderRadius: kBorderRadius12,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
