import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/presentation/cart.dart';
import 'package:food_app/providers/app_provider.dart';

class AddToCartBottomNavbar extends StatelessWidget {
  const AddToCartBottomNavbar({
    super.key,
    this.showOnEmptyCart = false,
    this.productId,
  });
  final bool showOnEmptyCart;
  final String? productId;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        final selectedProducts = ref.watch(selectedProductsProvider);

        if (selectedProducts.isEmpty && !showOnEmptyCart) {
          return const SizedBox.shrink();
        }

        final selectedProductsNotifier =
            ref.watch(selectedProductsProvider.notifier);

        final isProductSelected = selectedProducts.containsKey(productId);
        return SafeArea(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey[50],
              child: Text(
                selectedProductsNotifier.totalItems.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              '\$${selectedProductsNotifier.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Cart();
                    },
                  ),
                );
              },
              child: showOnEmptyCart
                  ? Text(
                      isProductSelected && productId != null
                          ? 'View Cart'
                          : 'Add to Cart',
                    )
                  : Text(
                      isProductSelected && productId != null
                          ? 'Add to Cart'
                          : 'View Cart',
                    ),
            ),
          ),
        );
      },
    );
  }
}
