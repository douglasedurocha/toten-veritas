import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toten/controllers/cart_controller.dart';

class CartItemList extends StatelessWidget {
  const CartItemList({super.key, required this.controller});

  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          itemCount: controller.itemCount.value,
          itemBuilder: (context, index) {
            return Container(
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 0.5,
                      icon: const Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        controller.removeFromCart(controller.cartItems[index]);
                      },
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      margin: const EdgeInsets.only(right: 15),
                      child: Image.asset(
                        controller.cartItems[index].product.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(() => Text(
                                "${controller.cartItems[index].quantity}x ",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              )),
                              SizedBox(
                              width: 180,
                              child: Text(
                                controller.cartItems[index].product.name,
                                style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ),
                            ],
                          ),
                          Text(
                              "R\$ ${controller.cartItems[index].product.price.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ))
                        ],
                      ),
                    ),
                    // const Spacer(),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 0),
                    //   child: Row(
                    //     children: [
                    //       IconButton(
                    //         iconSize: 0.5,
                    //         icon: const Icon(
                    //           Icons.remove_circle_outline,
                    //           size: 30,
                    //           color: Colors.blueAccent,
                    //         ),
                    //         onPressed: () {
                    //           controller.decrement(controller.cartItems[index]);
                    //         },
                    //       ),
                    //       Padding(
                    //         padding:
                    //             const EdgeInsets.symmetric(horizontal: 2.0),
                    //         child: Obx(() => Text(
                    //             controller.cartItems[index].quantity
                    //                 .toInt()
                    //                 .toString(),
                    //             style: const TextStyle(
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.black54,
                    //             ))),
                    //       ),
                    //       IconButton(
                    //         icon: const Icon(
                    //           Icons.add_circle,
                    //           size: 30,
                    //           color: Colors.blueAccent,
                    //         ),
                    //         onPressed: () {
                    //           controller.increment(controller.cartItems[index]);
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ));
          },
        ));
  }
}
