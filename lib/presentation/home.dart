import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/presentation/menu.dart';
import 'package:food_app/providers/app_data.dart';
import 'package:food_app/providers/app_provider.dart';
import 'package:food_app/widgets/restaurant_detail.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentRestaurant = ref.watch(appStateProvider);
    final allRestaurants = ref.watch(appStateProvider.notifier).restaurants;

    return Scaffold(
      backgroundColor: currentRestaurant.backgroundColor,
      appBar: AppBar(
        //* header
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ASAP', style: TextStyle(color: Colors.white)),
              Icon(Icons.arrow_right_alt),
              Text('Work', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // * PageView
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: allRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = allRestaurants[index];
                    return _restaurantView(index, restaurant);
                  },
                  onPageChanged: (index) {
                    ref.read(appStateProvider.notifier).changeRestaurant(index);
                  },
                ),
                // * Bottom button
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SafeArea(
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Menu(appData: currentRestaurant);
                              },
                            ),
                          );
                        },
                        child: const Text('Order from here'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _restaurantView(int index, AppData restaurant) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0;
        if (_pageController.position.haveDimensions) {
          value = index.toDouble() - (_pageController.page ?? 0);
          value = (value.abs() * 0.3).clamp(-1, 1);
        } else {
          value = index == 1 ? 0.3 : 0.0;
        }

        return Column(
          children: [
            // * Restaurant logo
            Center(
              child: Image.asset(
                restaurant.logo,
                height: 100,
                width: 250,
              ),
            ),

            // * Restaurant card
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.only(top: value * 120),
                child: _restaurantCard(restaurant),
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget _restaurantCard(AppData restaurant) {
  final product = restaurant.products[0];
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: restaurant.backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          margin: const EdgeInsets.all(20),
          child: Image.asset(
            product.imagePath,
            height: 180,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),

        // * Restaurant detail
        RestaurantDetail(
          product: product,
          companyName: restaurant.companyName,
        ),
      ],
    ),
  );
}
