import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:movie_challenge/common/extensions.dart';
import 'package:movie_challenge/common/settings_provider.dart';
import 'package:movie_challenge/common/widgets/loading_widget.dart';
import 'package:movie_challenge/common/widgets/problem_widget.dart';
import 'package:movie_challenge/features/popular_movies/bloc/popular_movies_bloc.dart';
import 'package:movie_challenge/features/popular_movies/widget/genre_selector.dart';
import 'package:movie_challenge/features/popular_movies/widget/popular_movie_widget.dart';
import 'package:provider/provider.dart';
import 'package:state_manager/state_manager.dart';

final List<String> genres = [
  "Thriller",
  "Action",
  "Comedy",
  "Science Fiction",
  "Fantasy",
  "Family",
  "Crime",
];

class PopularPage extends StatelessWidget {
  const PopularPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (settingsContext, settingsProvider, _) {
        return BlocBuilder<PopularMoviesBloc, RequestState>(
          builder: (context, state) {
            if (state is LOADING) {
              return LoadingWidget(message: state.message);
            } else if (state is ERROR) {
              return ProblemWidget(
                title: state.failure.toString(),
                message: state.failure.message,
                onTap: () {
                  context.read<PopularMoviesBloc>().add(Invoke(
                        params: const GetPopularMoviesParams(),
                      ));
                },
              );
            } else if (state is SUCCESS<List<IPopularMovie>>) {
              final popularMovies = state.data;
              if (popularMovies.isEmpty) {
                return ProblemWidget(
                    title: "No movies available",
                    message:
                        "You can mock elements y clicking the 'Mock movies' button",
                    buttonText: "Mock movies",
                    onTap: () {
                      context.read<PopularMoviesBloc>().add(Invoke(
                            params:
                                const GetPopularMoviesParams(forceRemote: true),
                          ));
                    });
              }
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      GenreSelector(
                        genres: genres,
                        onSelectedGenresChanged: (selectedGenres) {
                          context.read<PopularMoviesBloc>().add(Invoke(
                                params: FilterByGenre(
                                    selectedFilters: selectedGenres),
                              ));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: settingsProvider.isListView
                            ? _buildListView(popularMovies)
                            : _buildGridView(context, popularMovies),
                      ),
                    ],
                  ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }

  Widget _buildListView(List<IPopularMovie> movies) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        final movieIndex = 1 + index;
        return PopularMovieWidget(
          key: ValueKey('movie_element_$index'),
          movie: movie,
          position: movieIndex,
          height: 200,
        );
      },
    );
  }

  Widget _buildGridView(BuildContext context, List<IPopularMovie> movies) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: context.isLandscape() ? 0.82 : 0.55,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        final movieIndex = index + 1;
        return PopularMovieWidget(
          key: ValueKey('movie_element_$index'),
          movie: movie,
          position: movieIndex,
          height: 480,
        );
      },
    );
  }
}
