class Product {
  Product(this.name, this.value, this.quantity);

  final String name;
  final double value;
  final int quantity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          value == other.value &&
          quantity == other.quantity;

  @override
  int get hashCode => name.hashCode ^ value.hashCode ^ quantity.hashCode;
}
