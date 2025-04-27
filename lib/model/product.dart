
class Product {
  String name;
  String id;
  String description;
  double price;
  Product({
    required this.name,
    required this.id,
    required this.description,
    required this.price
  }
  );
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      price: (json['price']).toDouble(),
      description: json['description'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'description': description,
      
    };
  }

}