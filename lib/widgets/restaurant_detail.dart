import 'package:flutter/material.dart';
import 'package:food_app/providers/product.dart';

class RestaurantDetail extends StatelessWidget {
  const RestaurantDetail({
    super.key,
    required this.product,
    required this.companyName,
  });

  final String companyName;
  final Product product;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.grey,
      fontSize: 15,
    );
    return Column(
      children: [
        Text(
          companyName,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),
        // * Rating, products, and price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow),
                Text(product.rating.toString(), style: textStyle),
              ],
            ),
            Text(
              product.description,
              style: textStyle,
            ),
            Text(
              '\$${product.price}',
              style: textStyle,
            ),
          ],
        ),

        // * Preparation time
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[100],
          ),
          child: Text(
            '${product.preparationTime} Min',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
