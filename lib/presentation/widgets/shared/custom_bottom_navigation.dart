import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Iconsax.home_2_outline),
          label: 'Inicio'
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.category_2_outline),
          label: 'Categorías'
        ),
        BottomNavigationBarItem(
          icon: Icon(Iconsax.heart_outline),
          label: 'Favoritos'
        ),
      ]
    );
  }
}