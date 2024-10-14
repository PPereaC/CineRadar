import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/helpers/human_formats.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {

  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

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

    final firstLoading = ref.watch(firstLoadingProvider);
    if(firstLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies= ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    final colors = Theme.of(context).colorScheme;

    // Obtener el mes actual en formato texto
    final currentMonth = DateTime.now().month;
    final currentMonthName = HumanFormats.monthName(currentMonth);

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
                      subTitle: 'Ahora mismo',
                      loadNextPage: () {
                        ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                      },
                    ),
                
                    MovieHorizontalListview(
                      movies: upcomingMovies,
                      title: 'Proximamente',
                      subTitle: currentMonthName,
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