class Product {
  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourite = false});

  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavourite;
}
