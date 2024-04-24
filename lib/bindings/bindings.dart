import 'package:get/get.dart';
import 'package:toten/controllers/cart_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController());
  }
}