import 'package:flutter/material.dart';
// import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 16,
      child: FutureBuilder(
        future: Future.wait([
          DBHelper().getProductsOnSale(),
          DBHelper().getProductsByCategory('bebida'),
          DBHelper().getProductsByCategory('salgado'),
          DBHelper().getProductsByCategory('combo'),
          DBHelper().getProductsByCategory('doce'),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator()
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<ProductModel> productsOnSale = snapshot.data![0];
            List<ProductModel> bebidaProducts = snapshot.data![1];
            List<ProductModel> salgadoProducts = snapshot.data![2];
            List<ProductModel> comboProducts = snapshot.data![3];
            List<ProductModel> doceProducts = snapshot.data![4];

            var contentViews = [
              ContentView(
                tab: const CustomTab(
                    title: 'Em Promoção', icon: Icons.local_offer),
                content: ProductList(products: productsOnSale),
              ),
              ContentView(
                tab: const CustomTab(title: 'Bebidas', icon: Icons.local_drink),
                content: ProductList(products: bebidaProducts),
              ),
              ContentView(
                tab: const CustomTab(title: 'Salgados', icon: Icons.fastfood),
                content: ProductList(products: salgadoProducts),
              ),
              ContentView(
                tab: const CustomTab(title: 'Combos', icon: Icons.local_dining),
                content: ProductList(products: comboProducts),
              ),
              ContentView(
                tab: const CustomTab(title: 'Quitandas', icon: Icons.cake),
                content: ProductList(products: doceProducts),
              ),
            ];

            if (productsOnSale.isEmpty) {
              contentViews.removeAt(0);
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTabBar(
                  controller: tabController,
                  tabs: contentViews.map((e) => e.tab).toList(),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: contentViews.map((e) => e.content).toList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
