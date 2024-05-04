import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toten/bindings/bindings.dart';
import 'package:toten/views/ui/checkout.dart';
import 'package:toten/views/ui/home.dart';

void main() {
  GlobalBindings().dependencies();
  // DBHelper.shared().db;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Toten Veritas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (_) => const HomePage(),
        '/checkout': (_) => const CheckoutPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}