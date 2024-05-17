import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toten/bindings/bindings.dart';
import 'package:toten/views/ui/home.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  GlobalBindings().dependencies();

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1024, 768),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

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