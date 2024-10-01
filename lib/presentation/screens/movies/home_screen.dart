import 'package:cinehub/presentation/providers/providers.dart';
import 'package:cinehub/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation()
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {

  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies= ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    final colors = Theme.of(context).colorScheme;

    return Container(
      color: colors.surfaceContainerLowest,
      child: CustomScrollView(
        slivers: [
      
          SliverAppBar(
            backgroundColor: colors.surfaceContainerLowest,
            floating: true,
            flexibleSpace: const FlexibleSpaceBar(
              titlePadding: EdgeInsetsDirectional.only(start: 10, bottom: 10),
              title: CustomAppbar(),
            ),
          ),
      
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                
                    MoviesSlideshow(movies: slideShowMovies),
                
                    MovieHorizontalListview(
                      movies: nowPlayingMovies,
                      title: 'En cines',
                      subTitle: 'Lunes 20',
                      loadNextPage: () {
                        ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                      },
                    ),
                
                    MovieHorizontalListview(
                      movies: upcomingMovies,
                      title: 'Proximamente',
                      subTitle: 'En este mes',
                      loadNextPage: () {
                        ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                      },
                    ),
                
                    MovieHorizontalListview(
                      movies: popularMovies,
                      title: 'Populares',
                      // subTitle: 'En este mes',
                      loadNextPage: () {
                        ref.read(popularMoviesProvider.notifier).loadNextPage();
                      },
                    ),
                
                    MovieHorizontalListview(
                      movies: topRatedMovies,
                      title: 'Mejor calificadas',
                      subTitle: 'Desde siempre',
                      loadNextPage: () {
                        ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                      },
                    ),
      
                    const SizedBox(height: 10)
                    
                  ],
                );
              },
              childCount: 1
            )
          )
      
        ]
      ),
    );
  }
}