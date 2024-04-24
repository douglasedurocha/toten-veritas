import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toten/components/cart/cart_item.dart';
import 'package:toten/controllers/cart_controller.dart';

class CartItemList extends StatelessWidget {
  const CartItemList({super.key, required this.controller});

  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          itemCount: controller.itemCount.value,
          itemBuilder: (context, index) {
            return CartItem(index: index, controller: controller);
          },
        ));
  }
}