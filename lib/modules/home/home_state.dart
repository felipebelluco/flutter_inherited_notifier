import 'package:flutter/material.dart';
import 'package:inherited_notifier_sample/shared/models/product.dart';

class HomeState extends ChangeNotifier {
  List<Product> products = List.empty();
  
  HomeState() {
    products = [
      Product("Aquecedor De Ambientes Elétrico Residencial Quartzo Ventisol", 139.03, 481),
      Product("Tapete Peludo Felpudo Costa Oro 2,00x2,50 Palha Promoção", 161, 2097),
      Product("Kit 10 Cuecas Boxer Adulto + 12 Pares Meias Sport Longa", 98.90, 4022),
      Product("Bicicleta Aro 29 Dropp Z3 Câmbio Shimano 21 Vel Freio Discos", 1144.71, 2567),
      Product("Kit Cftv 4 Câmeras Multi Hd 720p 1mp Dvr Intelbras Mhdx 1104", 1091.09, 2162),
      Product("Samsung Galaxy A03 Core Dual SIM 32 GB blue 2 GB RAM", 759, 2137),
    ];
  }
}