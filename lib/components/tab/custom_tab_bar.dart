import 'package:flutter/material.dart';
import 'package:toten/components/tab/custom_tab.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key, required this.controller, required this.tabs});

  final TabController controller;
  final List<CustomTab> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(controller: controller, tabs: tabs);
  }
}