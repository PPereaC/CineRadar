import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomBottomNavigation extends StatelessWidget {

  final int currentIndex;

  const CustomBottomNavigation({super.key, required this.currentIndex});

  /// Navegar a la ruta correspondiente según el índice seleccionado
  /// 
  /// [context] Contexto de la aplicación
  /// [index] Índice seleccionado
  void onItemTapped(BuildContext context, int index) {

    // Navegar a la ruta correspondiente según el índice seleccionado
    switch(index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
    }

  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      backgroundColor: colors.surfaceContainerLowest,
      elevation: 0,
      currentIndex: currentIndex,
      onTap: (index) => onItemTapped(context, index),
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