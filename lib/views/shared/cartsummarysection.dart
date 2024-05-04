import 'package:flutter/material.dart';
import 'package:toten/components/checkout/cartsummary_list.dart';

class CartSummarySection extends StatelessWidget {
  const CartSummarySection({super.key, required this.cartItems, required this.total});

  final List cartItems;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 16,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Resumo do Pedido',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CartSummaryList(cartItems: cartItems),
            const SizedBox(height: 20),
            const Spacer(),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              height: 30,
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        foregroundColor: Colors.blue,
                        side: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back_ios),
                          SizedBox(width: 10),
                          Text(
                            'Voltar ao carrinho',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Total: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 25),
                    Text(
                      'R\$ ${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
