import 'package:toten/models/cart_item.dart';
import 'package:toten/models/product.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Rx<List<CartItemModel>> cartItems = Rx<List<CartItemModel>>([]);
  late CartItemModel cartItemModel;
  var itemCount = 0.obs;

  void addToCart(ProductModel product) {
    var productIndex = cartItems.value.indexWhere((element) => element.product == product);
    var productExists = productIndex != -1;

    if (productExists) {
      cartItems.value[productIndex].increment();
    } else {
      cartItemModel = CartItemModel(product: product, quantity: 1.obs);
      cartItems.value.add(cartItemModel);
      itemCount.value = cartItems.value.length;
    } 
    updateTotalPrice();
  }

  void removeFromCart(CartItemModel cartItem) {
    cartItems.value.remove(cartItem);
    itemCount.value = cartItems.value.length;
    updateTotalPrice();
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
    totalPrice.value = cartItems.value.fold(0, (sum, item) => sum + item.product.price * item.quantity.value);
  }

  @override
  void onInit() {
    super.onInit();
    ever(cartItems, (_) => updateTotalPrice());
  }
}