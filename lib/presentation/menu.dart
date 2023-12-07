import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/providers/app_data.dart';
import 'package:food_app/providers/app_provider.dart';
import 'package:food_app/providers/product.dart';
import 'package:food_app/widgets/add_to_cart_bottom_navbar.dart';
import 'package:food_app/widgets/food_detail_modal.dart';
import 'package:food_app/widgets/increase_and_decrease_button.dart';
import 'package:food_app/widgets/restaurant_detail.dart';
import 'package:food_app/widgets/sliver_title.dart';

class Menu extends StatelessWidget {
  const Menu({super.key, required this.appData});
  final AppData appData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          // * Header
          SliverPersistentHeader(
            delegate: CustomAppBar(appData),
            pinned: true,
          ),
        ],
        body: Consumer(
          builder: (_, ref, __) {
            final data = ref.watch(appStateProvider.notifier);

            final taggedCategories = data.getUniqueTagProducts;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemBuilder: (context, index) {
                        final product = taggedCategories[index];
                        return ListFoodItem(
                          imagePath: product.imagePath,
                          name: product.tag,
                          selected: product.tag == 'Breakfast',
                          backgroundColor: appData.backgroundColor,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 20);
                      },
                      itemCount: taggedCategories.length,
                    ),
                  ),
                ),

                // * Breakfast
                sliverTitle('Breakfast Value Meals'),
                _customSliverGrid(data.breakfastProducts, ref),

                // * Burgers
                sliverTitle('Burgers'),
                _customSliverGrid(data.burgerProducts, ref),

                // * Bottom padding
                if (ref.watch(selectedProductsProvider).isEmpty)
                  const SliverToBoxAdapter(
                    child: SafeArea(
                      child: SizedBox.shrink(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const AddToCartBottomNavbar(),
    );
  }

  Widget _customSliverGrid(List<Product> products, WidgetRef ref) {
    return SliverGrid.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return GridFoodItem(
          products.elementAt(index),
        );
      },
    );
  }
}

class ListFoodItem extends StatelessWidget {
  const ListFoodItem({
    super.key,
    required this.name,
    required this.imagePath,
    required this.selected,
    required this.backgroundColor,
  });
  final String name;
  final String imagePath;
  final bool selected;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: selected ? backgroundColor : Colors.transparent,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 65,
            height: 65,
            fit: BoxFit.contain,
          ),
          Text(
            name,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class GridFoodItem extends StatelessWidget {
  const GridFoodItem(
    this.product, {
    super.key,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.showFoodDetailModal(
                product: product,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.asset(
                    product.imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  product.name,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          const Spacer(),
          IncreaseOrDecreaseButton(product: product, showPrice: true),
          const Spacer(),
        ],
      ),
    );
  }
}

class CustomAppBar extends SliverPersistentHeaderDelegate {
  CustomAppBar(this.appData);
  final AppData appData;

  @override
  double get minExtent => kToolbarHeight * 4.5;

  @override
  double get maxExtent => kToolbarHeight * 6.5;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final shrinkPercentage =
        (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    final backgroundColor =
        Color.lerp(appData.backgroundColor, Colors.white, shrinkPercentage);

    final iconColor = Color.lerp(Colors.white, Colors.black, shrinkPercentage);

    final initialProduct = appData.products[0];

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: iconColor),
      flexibleSpace: SafeArea(
        child: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 30),
          child: Opacity(
            opacity: 1 - shrinkPercentage,
            child: Image.asset(
              initialProduct.imagePath,
              width: 200,
              height: 130,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: RestaurantDetail(
            product: initialProduct,
            companyName: appData.companyName,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
