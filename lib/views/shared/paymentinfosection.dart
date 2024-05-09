import 'package:flutter/material.dart';
import 'package:toten/models/cart_item.dart';
import 'package:toten/models/user.dart';
import 'package:toten/services/db_helper.dart';

class PaymentInfoSection extends StatefulWidget {
  const PaymentInfoSection({super.key, required this.cartItems, required this.total});
  
  final List<CartItemModel> cartItems;
  final double total;

  @override
  State<PaymentInfoSection> createState() => _PaymentInfoSectionState();
}

class _PaymentInfoSectionState extends State<PaymentInfoSection> {
  UserModel user = const UserModel(id: 0, name: '', balance: 0.0, email: '');

  Future<void> loadUserInfo(int userId) async {
    UserModel userData = await DBHelper().getUser(userId);

    setState(() {
      user = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 10,
        child: Column(
          children: [
            const Text(
              'Informações de Pagamento',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                  // width: 450,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Formas de Pagamento',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              splashColor: Colors.grey[300],
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.blue, width: 2),
                                ),
                                width: 145,
                                height: 80,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.card_membership),
                                    Text('Carteirinha Digital'),
                                  ],
                                ),
                              ),
                              onTap: () => {},
                            ),
                          ),
                          Container(
                            width: 145,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.credit_card),
                                Text(
                                  'Cartão de Crédito\n (indisponível)',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 145,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.money),
                                Text(
                                  'Cartão de Débito\n (indisponível)',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText:
                              'Toque para que o leitor digite o número da carteirinha',
                          hintText: 'Número da carteirinha',
                          border: OutlineInputBorder(),
                        ),
                        onFieldSubmitted: (value) => {
                          loadUserInfo(int.parse(value)),
                        },
                      ),
                      Divider(
                        color: Colors.grey[400],
                        thickness: 1,
                        height: 50,
                      ),
                      // Informações do aluno com base no número da carteirinha
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nome:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                (user.name.isNotEmpty) ? user.name : 'Não informado',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Saldo:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  Text(
                                    'R\$ ${user.balance.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(width: 5,),
                                  (user.balance < widget.total)
                                      ? const Text(
                                          '! Saldo insuficiente',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Center(
                        child: ElevatedButton(
                          onPressed: (user.balance > widget.total) ? () {
                            DBHelper().insertOrder(widget.cartItems, user);
                          } : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(450, 50),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Finalizar Pagamento',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ));
  }
}
