class Product {
  final String id;
  final String name;
  final String tag;
  final String imagePath;
  final String description;
  final String recipe;
  final double price;
  final double rating;
  final String preparationTime;
  Product({
    required this.id,
    required this.name,
    required this.tag,
    required this.imagePath,
    required this.description,
    required this.recipe,
    required this.price,
    required this.rating,
    required this.preparationTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'tag': tag,
      'imagePath': imagePath,
      'description': description,
      'recipe': recipe,
      'price': price,
      'rating': rating,
      'preparationTime': preparationTime,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      tag: map['tag'] as String,
      imagePath: map['imagePath'] as String,
      description: map['description'] as String,
      recipe: map['recipe'] as String,
      price: map['price'] as double,
      rating: map['rating'] as double,
      preparationTime: map['preparationTime'] as String,
    );
  }
}
