import 'package:toten/models/cart_item.dart';
import 'package:toten/models/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Rx<List<CartItemModel>> cartItems = Rx<List<CartItemModel>>([]);
  late CartItemModel cartItemModel;
  var itemCount = 0.obs;

  void addToCart(ProductModel product) {
    cartItemModel = CartItemModel(product: product, quantity: 1.obs);
    cartItems.value.add(cartItemModel);
    itemCount.value = cartItems.value.length;
  }

  void removeFromCart(CartItemModel cartItem) {
    cartItems.value.remove(cartItem);
    itemCount.value = cartItems.value.length;
  }

  void increment(CartItemModel cartItem){
    cartItem.increment();
  }

  void decrement(CartItemModel cartItem){
    cartItem.decrement();
  }
}