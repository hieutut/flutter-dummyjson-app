import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/metric_constants.dart';
import '../../../data/model/product/product.dart';
import '../../../routes/app_router.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BouncingButton.scaleDown(
      onTap: () {
        context.router.push(ProductDetailRoute(productId: product.id));
      },
      child: Padding(
        padding: kPadding16All,
        child: Row(
          children: [
            SizedBox.square(
              dimension: 80,
              child: ColoredBox(
                color: Colors.blueGrey.withValues(alpha: 0.1),
                child: product.thumbnail?.isNotEmpty == true
                    ? CoreImage(
                        product.thumbnail!,
                        size: 80,
                      )
                    : null,
              ),
            ),
            kBoxSpaceItem,
            Expanded(
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium,
              ),
            ),
            kBoxSpaceItem,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${product.discountPriceString}',
                  style: theme.textTheme.titleSmall,
                ),
                kBoxSpaceItem,
                BouncingButton.scaleUp(
                  onTap: () {},
                  child: Container(
                    width: kIconSize32,
                    height: kIconSize32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_shopping_cart_rounded,
                      color: Colors.black87,
                      size: kIconSize20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
