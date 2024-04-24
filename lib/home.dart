import 'package:flutter/material.dart';
import 'package:toten/components/cart/cart_list.dart';
import 'package:toten/components/tab/content_view.dart';
import 'package:toten/components/tab/custom_tab.dart';
import 'package:toten/components/tab/custom_tab_bar.dart';
import 'package:toten/components/products/product_list.dart';
import 'package:toten/models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController tabController; 

  static const List<ProductModel> products = [
    ProductModel(id: 1, name: 'Hambúrguer', price: 15.00, image: 'assets/product1.png', quantity: 10),
    ProductModel(id: 2, name: 'Refrigerante', price: 5.00, image: 'assets/product2.png', quantity: 10),
    ProductModel(id: 3, name: 'Coxinha', price: 4.00, image: 'assets/product3.png', quantity: 5),
    // Add more products as needed
  ];

  List<ContentView> contentViews = [
    ContentView(
      tab: const CustomTab(title: 'Bebidas', icon: Icons.local_drink),
      content: const Center(
        child: ProductList(products: products,)),),
    ContentView(
      tab: const CustomTab(title: 'Salgados', icon: Icons.fastfood),
      content: const Center(
        child: ProductList(products: products,)),),
    ContentView(
      tab: const CustomTab(title: 'Combos', icon: Icons.local_dining),
      content: const Center(
        child: ProductList(products: products,)),),
    ContentView(
      tab: const CustomTab(title: 'Quitandas', icon: Icons.cake),
      content: const Center(
        child: ProductList(products: products,)),),
    ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          Expanded(
            flex: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTabBar(controller: tabController, tabs: contentViews.map((e) => e.tab).toList()),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: contentViews.map((e) => e.content).toList(),
                  ),
                )
              ],
            ),
          ),
          // Expanded(flex: 1, child: Container()),
          const SizedBox(width: 10),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text('Pedido',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                  child: CartItemsList(),
                ),  
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(40.0),
                            child: Row(
                              children: [
                                Text('Total',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text('R\$ 30,00',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                foregroundColor: Colors.blue[900],
                                padding: const EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.print,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Finalizar Pedido',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          )
        ],
      ) 
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     CustomTabBar(controller: tabController, tabs: contentViews.map((e) => e.tab).toList()),
      //     SizedBox(
      //       height: 400,
      //       child: TabBarView(
      //         controller: tabController,
      //         children: contentViews.map((e) => e.content).toList(),
      //       ),
      //     )
      //   ],
      // )
    );
  }
}