import 'package:flutter/material.dart';
import 'package:toten/components/products/product.dart';
import 'package:toten/models/product.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Text(
          'Não há produtos nessa categoria',
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        padding: const EdgeInsets.only(right: 5, left: 5, bottom: 120),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 9/12,
        ),
        itemCount: products.length,
        itemBuilder: (context, int i) {
          final product = products[i];
          return Product(product: product);
        },
      ),
    );
  }
}