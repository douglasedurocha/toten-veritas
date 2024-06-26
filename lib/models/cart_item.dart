import 'package:get/get.dart';
import 'package:toten/models/product.dart';

class CartItemModel {
  final ProductModel product;
  RxInt quantity;
  RxBool isInStock = true.obs;

  CartItemModel({
    required this.product,
    required this.quantity,
  });

  void increment() {
    quantity++;
  }

  void decrement() {
    quantity--;
  }
}