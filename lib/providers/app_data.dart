import 'package:flutter/material.dart';
import 'package:food_app/providers/product.dart';

class AppData {
  final Color backgroundColor;
  final String logo;
  final String companyName;
  final List<Product> products;
  AppData({
    required this.backgroundColor,
    required this.logo,
    required this.companyName,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'backgroundColor': backgroundColor,
      'logo': logo,
      'companyName': companyName,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory AppData.fromMap(Map<String, dynamic> map) {
    return AppData(
      backgroundColor: Color(map['backgroundColor'] as int),
      logo: map['logo'] as String,
      companyName: map['companyName'] as String,
      products: (map['products'] as List<dynamic>)
          .map((e) => Product.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // get product by id
  Product getProductById(String id) {
    return products.firstWhere((element) => element.id == id);
  }
}
