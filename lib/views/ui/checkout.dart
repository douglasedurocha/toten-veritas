import 'package:flutter/material.dart';
import 'package:toten/controllers/cart_controller.dart';
import 'package:toten/models/cart_item.dart';
import 'package:toten/views/shared/cartsummarysection.dart';
import 'package:toten/views/shared/paymentinfosection.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.controller, required this.cartItems, required this.total});

  final CartController controller;
  final List<CartItemModel> cartItems;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Row(
          children: [
            CartSummarySection(cartItems: cartItems, total: total,),
            const SizedBox(width: 50),
            PaymentInfoSection(controller: controller, cartItems: cartItems, total: total),
          ],
        ),
      )
    );
  }
}