// import 'package:flutter/material.dart';
// import 'package:toten/components/tab/content_view.dart';
// import 'package:toten/components/tab/custom_tab.dart';
// import 'package:toten/components/tab/custom_tab_bar.dart';
// import 'package:toten/components/products/product.dart';
// import 'package:toten/components/products/product_list.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
//   late TabController tabController; 

//   static const List<Product> products = [
//     Product(name: 'Hamburguer', price: 15.00, image: 'assets/product1.png'),
//     Product(name: 'Refrigerante', price: 5.00, image: 'assets/product2.png'),
//     Product(name: 'Coxinha', price: 4.00, image: 'assets/product3.png'),
//     // Add more products as needed
//   ];

//   List<ContentView> contentViews = [
//     ContentView(
//       tab: const CustomTab(title: 'Bebidas', icon: Icons.local_drink),
//       content: const Center(
//         child: ProductList(products: products,)),),
//     ContentView(
//       tab: const CustomTab(title: 'Salgados', icon: Icons.fastfood),
//       content: const Center(
//         child: ProductList(products: products,)),),
//     ContentView(
//       tab: const CustomTab(title: 'Combos', icon: Icons.local_dining),
//       content: const Center(
//         child: ProductList(products: products,)),),
//     ContentView(
//       tab: const CustomTab(title: 'Quitandas', icon: Icons.cake),
//       content: const Center(
//         child: ProductList(products: products,)),),
//     ];

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: contentViews.length, vsync: this);
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         CustomTabBar(controller: tabController, tabs: contentViews.map((e) => e.tab).toList()),
//         Expanded(
//           child: TabBarView(
//             controller: tabController,
//             children: contentViews.map((e) => e.content).toList(),
//           ),
//         )
//       ],
//     );
//   }
// }