import 'package:flutter/material.dart';

class CartSummaryList extends StatelessWidget {
  const CartSummaryList({super.key, required this.cartItems});

  final List cartItems;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: DataTable(
          dataRowMinHeight: 30,
          dataRowMaxHeight: 70,
          headingTextStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          columns: const [
            DataColumn(label: Text('Produto')),
            DataColumn(label: Text('Quantidade')),
            DataColumn(label: Text('Preço total')),
          ],
          rows: cartItems.map((item) {
            return DataRow(cells: [
              DataCell(SizedBox(
                width: 550,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(item.product.image),
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(item.product.name),
                  ],
                ),
              )),
              DataCell(SizedBox(
                width: 50,
                child: Text(
                  item.quantity.toString(),
                  textAlign: TextAlign.center,
                ),
              )),
              DataCell(SizedBox(
                width: 100,
                child: Text('R\$ ${(item.product.price * item.quantity.value).toStringAsFixed(2)}')
                )),
            ]);
          }).toList()
        ),
      ),
    );
  }
}
