import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toten/models/product.dart';
import 'package:toten/controllers/cart_controller.dart';

class Product extends GetView<CartController> {
  const Product({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final String formattedPrice = "R\$ ${product.price.toStringAsFixed(2)}";

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
          ]),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.addToCart(product);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Image.asset(
                    product.image,
                    fit: BoxFit.contain,
                  ),
                  (product.price < product.initialPrice) ?
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'PROMOÇÃO',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ): const SizedBox(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 45,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                        ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Text(
                  formattedPrice,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black45,
                  ),
                ),
                (product.price < product.initialPrice)
                    ? Row(
                        children: [
                          const SizedBox(width: 5),
                          Text(
                            "R\$ ${product.initialPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black45,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
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
