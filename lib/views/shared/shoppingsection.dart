import 'package:flutter/material.dart';
import 'package:toten/components/tab/content_view.dart';
import 'package:toten/components/tab/custom_tab.dart';
import 'package:toten/components/tab/custom_tab_bar.dart';
import 'package:toten/components/products/product_list.dart';
import 'package:toten/models/product.dart';

class ShoppingSection extends StatefulWidget {
  const ShoppingSection({super.key});

  @override
  State<ShoppingSection> createState() => _ShoppingSectionState();
}

class _ShoppingSectionState extends State<ShoppingSection>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  static const List<ProductModel> products = [
    ProductModel(
        id: 1,
        name: 'Hambúrguer',
        price: 15.00,
        category: 'food',
        image: 'assets/product1.png',
        quantity: 10),
    ProductModel(
        id: 2,
        name: 'Refrigerante',
        price: 5.00,
        category: 'drink',
        image: 'assets/product2.png',
        quantity: 10),
    ProductModel(
        id: 3,
        name: 'Coxinha',
        price: 4.00,
        category: 'food',
        image: 'assets/product3.png',
        quantity: 5),
    // Add more products as needed
  ];

  List<ContentView> contentViews = [
    ContentView(
      tab: const CustomTab(title: 'Bebidas', icon: Icons.local_drink),
      content: const Center(
          child: ProductList(
        products: products,
      )),
    ),
    ContentView(
      tab: const CustomTab(title: 'Salgados', icon: Icons.fastfood),
      content: const Center(
          child: ProductList(
        products: products,
      )),
    ),
    ContentView(
      tab: const CustomTab(title: 'Combos', icon: Icons.local_dining),
      content: const Center(
          child: ProductList(
        products: products,
      )),
    ),
    ContentView(
      tab: const CustomTab(title: 'Quitandas', icon: Icons.cake),
      content: const Center(
          child: ProductList(
        products: products,
      )),
    ),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTabBar(
              controller: tabController,
              tabs: contentViews.map((e) => e.tab).toList()),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: contentViews.map((e) => e.content).toList(),
            ),
          )
        ],
      ),
    );
  }
}
