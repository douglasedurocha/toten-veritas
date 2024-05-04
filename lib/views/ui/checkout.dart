import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Row(
          children: [
            Expanded(
              flex: 16,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Resumo do Pedido',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 500,
                    child: SingleChildScrollView (
                      child: DataTable(
                        dataRowMinHeight: 30,
                        dataRowMaxHeight: 70,
                        columnSpacing: 260,
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
                        rows: const [
                          DataRow(
                            cells: [
                              DataCell(
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/product1.png'),
                                      width: 50,
                                      height: 50,
                                    ),
                                    SizedBox(width: 10,),
                                    Text('Produto 1'),
                                  ],
                                )
                              ),
                              DataCell(
                                Text(
                                  '1',
                                  textAlign: TextAlign.center,
                                )
                              ),
                              DataCell(Text('R\$ 10.00')),
                            ]
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/product1.png'),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Text('Coxinha'),
                                  ],
                                )
                              ),
                              DataCell(Text('2')),
                              DataCell(Text('R\$ 20.00')),
                            ]
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/product1.png'),
                                      width: 50,
                                      height: 50,
                                    ),
                                    Text('Hamburguer'),
                                  ],
                                )
                              ),
                              DataCell(Text('3')),
                              DataCell(Text('R\$ 30.00')),
                            ]
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(150, 50),
                            foregroundColor: Colors.blue,
                            side: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.arrow_back_ios),
                              SizedBox(width: 10),
                              Text(
                                'Voltar ao carrinho',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'Total: ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 25),
                        const Text(
                          'R\$ 60.00',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  )
                ],
              )
            ),
            const SizedBox(width: 50),
            Expanded(
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
                                      border: Border.all(color: Colors.blue, width: 2),
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
                                  onTap:() => {},
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
                              labelText: 'Número da Carteirinha',
                              hintText: 'Digite o número da carteirinha',
                              border: OutlineInputBorder(),
                            ),
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
                                  const Text(
                                    'João da Silva',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                    ),
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
                                  const Text(
                                    'R\$ 40',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Realizar pagamento
                              },
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
                      )
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}