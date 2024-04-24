import 'package:flutter/material.dart';
import 'package:toten/components/products/product.dart';
import 'package:toten/models/product.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 9/12,
        ),
        itemCount: products.length,
        itemBuilder: (context, int i) {
          final product = products[i]; // Remove the name of the function expression
          return Product(product: product);
        },
      ),
    );
  }
}