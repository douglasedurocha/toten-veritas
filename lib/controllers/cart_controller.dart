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
      cartItems[productIndex].increment();
      updateTotalPrice();
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
    cartItem.increment();
    updateTotalPrice();
  }

  void decrement(CartItemModel cartItem){
    if (cartItem.quantity.value > 0){
      cartItem.decrement();
      updateTotalPrice();
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
}