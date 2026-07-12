class CartModel {
  final int id;
  final int userId;
  final List<CartItem> products;
  final double total;
  final double discountedTotal;
  final int totalProducts;
  final int totalQuantity;

  CartModel({
    required this.id,
    required this.userId,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      products: (json['products'] as List? ?? [])
          .map((item) => CartItem.fromJson(item))
          .toList(),
      total: (json['total'] ?? 0).toDouble(),
      discountedTotal: (json['discountedTotal'] ?? 0).toDouble(),
      totalProducts: json['totalProducts'] ?? 0,
      totalQuantity: json['totalQuantity'] ?? 0,
    );
  }
}

class CartItem {
  final int id;
  final String title;
  final double price;
  final double discountedPrice;
  final int quantity;
  final String thumbnail;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.discountedPrice,
    required this.quantity,
    required this.thumbnail,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountedPrice: (json['discountedPrice'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  double get total => discountedPrice * quantity;
}