import 'package:flutter/material.dart';
import 'package:toten/views/shared/cartsection.dart';
import 'package:toten/views/shared/shoppingsection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: const Row(
        children: [
          Expanded(
            flex: 16,
            child: ShoppingSection(),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 8,
            child: CartSection(),
          )
        ],
      )
    );
  
  }
}