import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common/localization/localization.gen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends BaseStatefulWidgetState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(L.cart)),
      ),
    );
  }
}
