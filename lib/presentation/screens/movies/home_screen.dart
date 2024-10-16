import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/shared/custom_bottom_navigation.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';
  final StatefulNavigationShell navigationShell;

  const HomeScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavigation(navigationShell: navigationShell),
    );
  }
}