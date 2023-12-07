import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/data/app_data.dart';
import 'package:food_app/providers/app_data.dart';
import 'package:food_app/providers/product.dart';

class AppState extends StateNotifier<AppData> {
  AppState() : super(DataRepository().restaurants[0]);

  final data = DataRepository();

  List<AppData> get restaurants => data.restaurants;

  List<Product> get products {
    return data.products.map((e) => Product.fromMap(e)).toList();
  }

  List<Product> get breakfastProducts {
    return data.products
        .map((e) => Product.fromMap(e))
        .where((e) => e.tag.contains('Breakfast'))
        .toList();
  }

  List<Product> get burgerProducts {
    return data.products
        .map((e) => Product.fromMap(e))
        .where((e) => e.tag.contains('Burger'))
        .toList();
  }

  // filter products by tag and return a unique list of products
  List<Product> get getUniqueTagProducts {
    List<Product> uniqueProducts = [];
    for (var product in data.products) {
      var productFromMap = Product.fromMap(product);
      if (!uniqueProducts.any((p) => p.tag == productFromMap.tag)) {
        uniqueProducts.add(productFromMap);
      }
    }
    return uniqueProducts;
  }

  void changeRestaurant(int index) => state = restaurants[index];
}

final appStateProvider = StateNotifierProvider<AppState, AppData>((ref) {
  return AppState();
});

class SelectedProducts extends StateNotifier<Map<String, int>> {
  SelectedProducts() : super({});

  final products = DataRepository().products.map((e) => Product.fromMap(e));

  void addProduct(String productId) {
    if (state.containsKey(productId)) {
      state[productId] = state[productId]! + 1;
    } else {
      state[productId] = 1;
    }
    state = Map.from(state);
  }

  void removeProduct(String productId) {
    if (state.containsKey(productId)) {
      if (state[productId]! > 1) {
        state[productId] = state[productId]! - 1;
      } else {
        state.remove(productId);
      }
    }
    state = Map.from(state);
  }

  void clear() {
    state = {};
  }

  bool isProductSelected(int productId) {
    return state.containsKey(productId);
  }

  double get totalPrice {
    return state.entries.fold(0, (previousValue, element) {
      return previousValue +
          products.firstWhere((product) => product.id == element.key).price *
              element.value;
    });
  }

  int get totalItems {
    return state.entries.fold(0, (previousValue, element) {
      return previousValue + element.value;
    });
  }

  List<Product> get selectedProducts {
    return products.where((product) => state.containsKey(product.id)).toList();
  }

  List<Product> _suggestionProducts = [];

  List<Product> get suggestionProducts {
    final filteredProducts = List<Product>.from(
        products.where((product) => !state.containsKey(product.id)).toList())
      ..shuffle();
    if (_suggestionProducts.isEmpty) {
      _suggestionProducts = filteredProducts.take(6).toList();
    } else {
      _suggestionProducts = _suggestionProducts
          .map((product) =>
              state.containsKey(product.id) ? filteredProducts.first : product)
          .toList();
    }
    return _suggestionProducts;
  }
}

final selectedProductsProvider =
    StateNotifierProvider<SelectedProducts, Map<String, int>>((ref) {
  return SelectedProducts();
});
