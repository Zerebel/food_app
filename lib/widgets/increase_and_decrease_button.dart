import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/providers/app_provider.dart';
import 'package:food_app/providers/product.dart';

class IncreaseOrDecreaseButton extends ConsumerWidget {
  const IncreaseOrDecreaseButton({
    super.key,
    required this.product,
    this.showPrice = false,
  });

  final Product product;
  final bool showPrice;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProducts = ref.watch(selectedProductsProvider);
    return Row(
      children: [
        if (showPrice)
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        if (showPrice) const Spacer(),
        if (selectedProducts.containsKey(product.id))
          _increaseAndDecreaseButton(
            count: selectedProducts[product.id]!,
            onIncrease: () {
              ref
                  .read(selectedProductsProvider.notifier)
                  .addProduct(product.id);
            },
            onDecrease: () {
              ref
                  .read(selectedProductsProvider.notifier)
                  .removeProduct(product.id);
            },
          ),
        if (!selectedProducts.containsKey(product.id))
          IconButton(
            onPressed: () {
              ref
                  .read(selectedProductsProvider.notifier)
                  .addProduct(product.id);
            },
            icon: const Icon(Icons.add_circle_outline_outlined),
            color: Colors.grey[500],
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            ),
          ),
      ],
    );
  }

  Widget _increaseAndDecreaseButton({
    required int count,
    required Function() onIncrease,
    required Function() onDecrease,
  }) {
    final iconButtonStyle = IconButton.styleFrom(
      padding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrease,
            icon: const Icon(Icons.remove),
            style: iconButtonStyle,
          ),
          Text(
            count.toString(),
            textAlign: TextAlign.center,
          ),
          IconButton(
            onPressed: onIncrease,
            icon: const Icon(Icons.add),
            style: iconButtonStyle,
          ),
        ],
      ),
    );
  }
}
