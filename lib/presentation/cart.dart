import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/food_app_assets.dart';
import 'package:food_app/presentation/place_order.dart';
import 'package:food_app/providers/app_provider.dart';
import 'package:food_app/widgets/sliver_title.dart';
import 'package:food_app/widgets/increase_and_decrease_button.dart';

class Cart extends ConsumerWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPrice = ref.watch(selectedProductsProvider.notifier).totalPrice;
    return Scaffold(
        backgroundColor: Colors.grey[20],
        appBar: AppBar(
          title: Text(ref.watch(appStateProvider).companyName),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          scrolledUnderElevation: 0,
        ),
        body: ref.watch(selectedProductsProvider).isNotEmpty
            ? CustomScrollView(
                slivers: [
                  //* list of selected products
                  sliverTitle('Your Order'),
                  sliverList(ref: ref),

                  //* suggestions
                  sliverTitle('You might like'),
                  suggestions(ref: ref),

                  //* total price
                  sliverTitle('Total'),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          orderDetail(
                            title: 'Subtotal',
                            value: '\$ $totalPrice',
                            dimmed: true,
                          ),
                          orderDetail(
                            title: 'Delivery fee (Free)',
                            value: '\$ 0',
                            colored: true,
                          ),
                          orderDetail(
                            title: 'Total',
                            value: '\$ $totalPrice',
                          ),
                        ],
                      ),
                    ),
                  ),

                  //* payment method
                  sliverTitle('Pay with'),
                  SliverToBoxAdapter(
                    child: ListTile(
                      leading: Image.asset(
                        FoodAppAssets.applepay,
                        width: 50,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      title: Text('Apple Pay',
                          style: Theme.of(context).textTheme.bodyLarge),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                      visualDensity: const VisualDensity(horizontal: -4),
                    ),
                  ),
                ],
              )
            : const Center(child: Text('No items in your cart')),
        persistentFooterButtons: [
          SafeArea(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton(
                onPressed: ref.watch(selectedProductsProvider).isNotEmpty
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const PlaceOrder();
                            },
                          ),
                        );
                      }
                    : null,
                child: Text(
                  'Pay \$ $totalPrice',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ]);
  }

  Widget orderDetail({
    required String title,
    required String value,
    bool colored = false,
    bool dimmed = false,
  }) {
    final style = TextStyle(
      fontSize: 14,
      color: colored ? Colors.green : Colors.black,
    );
    return ListTile(
      leading: Text(
        title,
        style: style.copyWith(
          color: dimmed ? Colors.grey : style.color,
        ),
      ),
      trailing: Text(
        value,
        style: style,
      ),
      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget sliverList({
    required WidgetRef ref,
  }) {
    final selectedProducts =
        ref.watch(selectedProductsProvider.notifier).selectedProducts;

    if (selectedProducts.isEmpty) return const SliverToBoxAdapter();
    return SliverList.separated(
      itemCount: selectedProducts.length,
      itemBuilder: (context, index) {
        final product = selectedProducts[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListTile(
            tileColor: Colors.grey[50],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            leading: Image.asset(
              product.imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.contain,
            ),
            title: Text(product.name,
                style: Theme.of(context).textTheme.bodyLarge),
            subtitle: Text('\$${product.price}'),
            trailing: SizedBox(
              width: 80,
              child: IncreaseOrDecreaseButton(product: product),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }

  Widget suggestions({
    required WidgetRef ref,
  }) {
    final suggestedProducts =
        ref.watch(selectedProductsProvider.notifier).suggestionProducts;

    if (suggestedProducts.isEmpty) return const SliverToBoxAdapter();
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          itemCount: suggestedProducts.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final product = suggestedProducts[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              width: 290,
              child: ListTile(
                leading: Image.asset(
                  product.imagePath,
                  width: 70,
                  fit: BoxFit.contain,
                ),
                title: Text(product.name,
                    style: Theme.of(context).textTheme.labelLarge),
                subtitle: Text('\$${product.price}'),
                trailing: Container(
                  width: 40,
                  alignment: Alignment.bottomRight,
                  child: IncreaseOrDecreaseButton(product: product),
                ),
                contentPadding: EdgeInsets.zero,
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 20),
        ),
      ),
    );
  }
}
