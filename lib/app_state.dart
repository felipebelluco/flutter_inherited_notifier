import 'package:flutter/material.dart';
import 'package:inherited_notifier_sample/modules/cart/cart.dart';
import 'package:inherited_notifier_sample/shared/models/product.dart';

class AppState extends ChangeNotifier {
  String? name;
  bool logged = false;

  List<Product> cart = List.empty(growable: true);

  void changeName(String newName) {
    name = newName;
    if (!logged) {
      logged = true;
    }
    notifyListeners();
  }

  void showCart(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
        builder: (builder) => const Cart(), fullscreenDialog: true));
  }

  void addToCart(BuildContext context, Product product) {
    cart.add(product);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${product.name} was added to the cart")));

    notifyListeners();
  }
}
