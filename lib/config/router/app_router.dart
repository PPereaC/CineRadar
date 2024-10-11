import 'package:cinehub/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => HomeScreen(navigationShell: navigationShell),
      branches: [

        // Inicio
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeView(),
              routes: [
                GoRoute(
                  path: 'movie/:id',
                  name: MovieScreen.name,
                  builder: (context, state) {
                    // Obtenemos el ID de la película a través de la ruta
                    final movieID = state.pathParameters['id'] ?? 'no-id';
                    return MovieScreen(movieId: movieID);
                  },
                )
              ]
            )
          ]
        ),

        // Categorías
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              builder: (context, state) => const CategoriesView(),
            )
          ]
        ),

        // Favoritos
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesView(),
            )
          ]
        )



      ],
    )

  ]
);