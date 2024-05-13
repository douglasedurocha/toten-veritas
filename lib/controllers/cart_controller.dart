import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:toten/models/cart_item.dart';
import 'package:toten/models/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxList<CartItemModel> cartItems = RxList<CartItemModel>([]);
  late CartItemModel cartItemModel;
  var itemCount = 0.obs;
  RxBool isCartEmpty = true.obs;

  @override
  void onInit() {
    super.onInit();
    ever(cartItems, (_) {
      updateTotalPrice();
    });
  }

  void addToCart(ProductModel product) {
    var productIndex = cartItems.indexWhere((element) => element.product == product);
    var productExists = productIndex != -1;

    if (productExists) {
      increment(cartItems[productIndex]);
    } else {
      cartItemModel = CartItemModel(product: product, quantity: 1.obs);
      cartItems.add(cartItemModel);
      itemCount.value = cartItems.length;
    } 
  }

  void removeFromCart(CartItemModel cartItem) {
    cartItems.remove(cartItem);
    itemCount.value = cartItems.length;
  }

  void increment(CartItemModel cartItem){
    if (cartItem.product.quantity > cartItem.quantity.value){
      cartItem.increment();
      updateTotalPrice();
      updateStock(cartItem.product);
    }else{
      showStyledToast(
        child: const Text(
          'Quantidade indisponível no estoque',
          style: TextStyle(fontSize: 16),
        ),
        context: ToastProvider.context,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void decrement(CartItemModel cartItem){
    if (cartItem.quantity.value > 0){
      cartItem.decrement();
      updateTotalPrice();
      updateStock(cartItem.product);
    }
  }

  RxDouble totalPrice = RxDouble(0);

  void updateTotalPrice() {
    totalPrice.value = cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity.value);
    if (totalPrice.value > 0) {
      isCartEmpty.value = false;
      return;
    }
    isCartEmpty.value = true;
  }

  void updateStock(ProductModel product) {
    var productIndex = cartItems.indexWhere((element) => element.product == product);
    if (productIndex != -1) {
      cartItems[productIndex].isInStock.value = product.quantity > cartItems[productIndex].quantity.value;
    }
  }

  void clearCart() {
    cartItems.clear();
    itemCount.value = 0;
  }
}