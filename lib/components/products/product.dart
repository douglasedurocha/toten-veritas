import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toten/models/product.dart';
import 'package:toten/controllers/cart_controller.dart';

class Product extends GetView<CartController> {
  const Product({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context){
    final String formattedPrice = "R\$${product.price.toStringAsFixed(2)}";

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFCFCFCF),
            blurRadius: 4,
            offset: Offset(2, 3),
          )
        ]
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              product.image,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 45,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text (
                  product.name,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Text(
                  formattedPrice,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    size: 45,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    controller.addToCart(product);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}