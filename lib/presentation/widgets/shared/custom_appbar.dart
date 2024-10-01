import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [

              // TODO: Cambiar por el logo de la app
              Icon(Icons.movie_outlined, color: colors.primary, size: 28,),

              const SizedBox(width: 10),
              
              Text('CineHub', style: titleStyle,),

              const Spacer(),

              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.search_normal_outline)
              ),

            ],
          ),
        ),
      ),
    );
  }
}