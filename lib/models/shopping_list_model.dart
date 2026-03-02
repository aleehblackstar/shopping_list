import 'product_model.dart';

class ShoppingListModel {
  String name;
  List<ProductModel> products;

  ShoppingListModel({
    required this.name,
    required this.products,
  });

  
  double get totalBought => products
      .where((p) => p.isBought)
      .fold(0, (sum, p) => sum + p.value);

  double get totalNotBought => products
      .where((p) => !p.isBought)
      .fold(0, (sum, p) => sum + p.value);

 
  String get progressText => "${products.where((p) => p.isBought).length}/${products.length}";

  
  double get progressPercentage => products.isEmpty 
      ? 0.0 
      : products.where((p) => p.isBought).length / products.length;
}