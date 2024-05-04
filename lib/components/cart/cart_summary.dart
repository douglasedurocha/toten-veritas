import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toten/controllers/cart_controller.dart';
import 'package:toten/views/ui/checkout.dart';

class CartSummary extends StatefulWidget {
  const CartSummary({super.key, required this.controller});

  final CartController controller;

  @override
  State<CartSummary> createState() => _CartSummaryState();
}

class _CartSummaryState extends State<CartSummary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Obx(() => Text(
                        "R\$ ${widget.controller.totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              child: Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.blue[900],
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ), 
                onPressed: widget.controller.isCartEmpty.value ? null : () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(
                        cartItems: widget.controller.cartItems,
                        total: widget.controller.totalPrice.value
                      )
                    )
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.print,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Finalizar Pedido',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
