import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context){
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
                onPressed: (){},
              ),
              Container(
                height: 70,
                width: 70,
                margin: const EdgeInsets.only(right: 15),
                child: Image.asset(
                  "assets/product1.png",
                  fit: BoxFit.contain,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product 1",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      )
                    ),
                    Text(
                      "R\$15,00",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,                        
                      )
                    )
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 0.5,
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        size: 30,
                        color: Colors.blueAccent,
                      ),
                      onPressed: (){},
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        "2",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,                        
                        )
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle,
                        size: 30,
                        color: Colors.blueAccent,
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
              )
            ],
          )
        );
  }
}