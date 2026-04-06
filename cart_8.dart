import 'product.dart';

class Cart {

  List<Product> items = [];

  void addProduct(Product product) {
    items.add(product);
  }

  void removeProduct(Product product) {
    items.remove(product);
  }

  double getTotalPrice() {
    double total = 0;

    for (var item in items) {
      total += item.price;
    }

    return total;
  }
}