import 'package:flutter/material.dart';
import 'package:toten/views/shared/cartsummarysection.dart';
import 'package:toten/views/shared/paymentinfosection.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.cartItems, required this.total});

  final List cartItems;
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
            const PaymentInfoSection(),
          ],
        ),
      )
    );
  }
}