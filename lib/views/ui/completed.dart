import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shell/shell.dart';
import 'package:toten/controllers/cart_controller.dart';
import 'package:toten/models/cart_item.dart';
import 'package:toten/models/user.dart';
import 'package:toten/services/db_helper.dart';
import 'package:toten/views/ui/home.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({super.key, required this.controller, required this.cartItems, required this.user});

  final CartController controller;
  final List<CartItemModel> cartItems;
  final UserModel user;

  @override
  State<CompletedPage> createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  Future<void> _processOrder() async {
    final dbHelper = DBHelper();
    final orderId = await dbHelper.insertOrder(widget.cartItems, widget.user);
    
    try {
      final shell = Shell();
      await shell.start('./finalizacaovenda.sh', arguments: [orderId.toString()]);
    } catch (e) {
      debugPrint('Error executing finalizacaovenda.sh: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 4), () {
      widget.controller.clearCart();
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => const HomePage()
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: FutureBuilder(
        future: _processOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 400, width: 400, child: Lottie.asset('assets/error.json', repeat: false)),
                  const SizedBox(height: 20),
                  const Text(
                    'Erro ao realizar pedido!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ), 
                  ),
                ],
              )
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 400, width: 400, child: Lottie.asset('assets/success.json', repeat: false)),
                  const SizedBox(height: 20),
                  const Text(
                    'Pedido realizado com sucesso!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ), 
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}