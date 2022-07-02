import 'package:flutter/material.dart';
import 'package:inherited_notifier_sample/app_state.dart';
import 'package:inherited_notifier_sample/shared/models/product.dart';
import 'package:inherited_notifier_sample/shared/provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.read<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Visibility(
        visible: appState.cart.isNotEmpty,
        child: ListView.builder(
            itemCount: appState.cart.length,
            itemBuilder: (context, index) {
              Product product = appState.cart[index];
              return ListTile(
                  title: Text(product.name),
                  subtitle: Text("R\$ ${product.value}"),
                  trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart_outlined),
                      onPressed: () {}));
            }),
        replacement: Center(
          child: Text("The cart is empty!",
              style: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
    );
  }
}
