class Product {
  final String? id;
  final String name;
  final String price;
  final String qty;
  final String imageUrl;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() =>
      {'name': name, 'price': price, 'qty': qty, 'imageUrl': imageUrl};

  static Product fromJson(Map<String, dynamic> json, String id) => Product(
      id: id,
      name: json['name'],
      price: json['price'],
      qty: json['qty'],
      imageUrl: json['imageUrl']);
}
