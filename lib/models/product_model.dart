class ProductModel {
  String name;
  double value;
  bool isBought;

  ProductModel({
    required this.name,
    required this.value,
    this.isBought = false,
  });
}