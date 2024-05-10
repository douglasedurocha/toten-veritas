import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toten/bindings/bindings.dart';
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
      home: const ToastProvider(child: HomePage()),
      debugShowCheckedModeBanner: false,
    );
  }
}