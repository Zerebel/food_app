import 'package:flutter/material.dart';
import 'package:food_app/food_app_assets.dart';
import 'package:food_app/providers/product.dart';
import 'package:food_app/widgets/add_to_cart_bottom_navbar.dart';

extension ShowFoodDetail on BuildContext {
  void showFoodDetailModal({
    required Product product,
  }) {
    final theme = Theme.of(this);
    showModalBottomSheet(
      showDragHandle: true,
      context: this,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //* food image
              Image.asset(
                product.imagePath,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
              //* food name
              Text(
                product.name,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              //* food price
              Text(
                '\$${product.price}',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 15),
              //* food recipe
              Text(
                product.recipe,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(height: 20),
              //* food recipe list
              const SizedBox(
                height: 100,
                child: RecipeList(),
              ),

              const SizedBox(height: 20),
              //* add to cart button
              AddToCartBottomNavbar(
                showOnEmptyCart: true,
                productId: product.id,
              )
            ],
          ),
        );
      },
    );
  }
}

class RecipeList extends StatelessWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {'name': 'Big Bun', 'image': FoodAppAssets.bun},
      {'name': 'Beef Patty', 'image': FoodAppAssets.beef_patty},
      {'name': 'Lettuce', 'image': FoodAppAssets.lettuce},
      {'name': 'Pickle', 'image': FoodAppAssets.pickle}
    ];
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      separatorBuilder: (context, index) => const SizedBox(width: 20),
      itemBuilder: (context, index) {
        final item = data[index];
        return Column(
          children: [
            CircleAvatar(
              radius: 35,
              child: Image.asset(
                item['image']!,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 5),
            Text(item['name']!, style: Theme.of(context).textTheme.labelSmall),
          ],
        );
      },
    );
  }
}
