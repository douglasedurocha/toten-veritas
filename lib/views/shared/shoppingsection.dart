import 'package:flutter/material.dart';
import 'package:toten/components/tab/content_view.dart';
import 'package:toten/components/tab/custom_tab.dart';
import 'package:toten/components/tab/custom_tab_bar.dart';
import 'package:toten/components/products/product_list.dart';
import 'package:toten/models/product.dart';
import 'package:toten/services/db_helper.dart';

class ShoppingSection extends StatefulWidget {
  const ShoppingSection({super.key});

  @override
  State<ShoppingSection> createState() => _ShoppingSectionState();
}

class _ShoppingSectionState extends State<ShoppingSection>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late List<ContentView> contentViews;

  FutureBuilder<List<ProductModel>> getProductsByCategory(String category) {
    return FutureBuilder<List<ProductModel>>(
      future: DBHelper().getProductsByCategory(category),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ProductList(products: snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    contentViews = [
      ContentView(
        tab: const CustomTab(title: 'Bebidas', icon: Icons.local_drink),
        content: getProductsByCategory('bebida'), 
      ),
      ContentView(
        tab: const CustomTab(title: 'Salgados', icon: Icons.fastfood),
        content: getProductsByCategory('salgado'),
      ),
      ContentView(
        tab: const CustomTab(title: 'Combos', icon: Icons.local_dining),
        content: getProductsByCategory('combo'),
      ),
      ContentView(
        tab: const CustomTab(title: 'Quitandas', icon: Icons.cake),
        content: getProductsByCategory('doce'),
      ),
    ];
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
