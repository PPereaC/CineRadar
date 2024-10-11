import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomBottomNavigation extends StatelessWidget {

  final StatefulNavigationShell navigationShell;

  const CustomBottomNavigation({super.key, required this.navigationShell});

  /// Navegar a la ruta correspondiente según el índice seleccionado
  /// 
  /// [context] Contexto de la aplicación
  /// [index] Índice seleccionado
  void onItemTapped(BuildContext context, int index) {

    /// Alternamos entre vistas mediante el método goBranch, este método
    /// garantiza que se restaure el último estado de navegación para la
    /// rama seleccionada.
    navigationShell.goBranch(
      index,
      // Soporte para ir a la ubicación inicial de la rama.
      initialLocation: index == navigationShell.currentIndex,
    );

  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      backgroundColor: colors.surfaceContainerLowest,
      elevation: 0,
      currentIndex: navigationShell.currentIndex,
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