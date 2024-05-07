import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toten/components/cart/cart_list.dart';
import 'package:toten/components/cart/cart_summary.dart';
import 'package:toten/controllers/cart_controller.dart';

class CartSection extends GetView<CartController> {
  const CartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(25.0),
          child: Row(
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                'Pedido',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 500,
          child: CartItemList(controller: controller),
        ),
        Expanded(
          child: CartSummary(controller: controller),
        )
      ],
    );
  }
}