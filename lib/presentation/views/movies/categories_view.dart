import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class CategoriesView extends ConsumerStatefulWidget {
  const CategoriesView({super.key});

  @override
  CategoriesViewState createState() => CategoriesViewState();
}

class CategoriesViewState extends ConsumerState<CategoriesView> {

  @override
  void initState() {
    super.initState();
    ref.read(genresProvider);
  }

  @override
  Widget build(BuildContext context) {

    final genresAsyncValue = ref.watch(genresProvider);
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: genresAsyncValue.when(
          data: (genres) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dos géneros por fila
                childAspectRatio: 3 / 2, // Relación de aspecto para las tarjetas
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(10),
              itemCount: genres.length,
              itemBuilder: (context, index) {
                final genre = genres[index];
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: colors.secondaryContainer,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            genre.name,
                            style: TextStyle(
                              fontSize: text.bodyLarge!.fontSize,
                              fontWeight: FontWeight.bold,
                              color: text.bodyLarge!.color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}