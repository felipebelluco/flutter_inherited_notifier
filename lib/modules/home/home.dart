import 'package:flutter/material.dart';
import 'package:inherited_notifier_sample/app_state.dart';
import 'package:inherited_notifier_sample/modules/home/home_state.dart';
import 'package:inherited_notifier_sample/shared/provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppState appState = context.read<AppState>();
    HomeState state = context.watch<HomeState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Shop"), actions: [
        IconButton(
            onPressed: () => appState.showCart(context),
            icon: const Icon(Icons.shopping_cart))
      ]),
      body: ListView.builder(
          itemCount: state.products.length,
          itemBuilder: (builder, index) {
            var product = state.products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text("R\$ ${product.value}"),
              trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart_outlined),
                  onPressed: () => appState.addToCart(context, product)),
            );
          }),
    );
  }
}
