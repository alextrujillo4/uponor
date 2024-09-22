import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:movie_challenge/common/app_strings.dart';
import 'package:movie_challenge/common/widgets/icon_button_widget.dart';
import 'package:movie_challenge/features/create_movie/page/create_movie_screen.dart';
import 'package:movie_challenge/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:state_manager/state_manager.dart';

class MovieDetailWidget extends StatelessWidget {
  final IPopularMovie movie;

  const MovieDetailWidget({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 64,
          ),
          Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: 240,
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
              child: Text(movie.title,
                  style: Theme.of(context).textTheme.headlineMedium)),
          const SizedBox(
            height: 16,
          ),
          _buildStarRating(movie.voteAverage),
          const SizedBox(
            height: 16,
          ),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.overview,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(movie.overview),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Text(
                        AppStrings.popularity,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(": ${movie.popularity.toString()}"),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Chip(
            label: Text(
              'Release Date: ${_formatDate(movie.releaseDate)}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('${AppStrings.genres}:',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Wrap(
            children: movie.genres
                .map((genre) => Padding(
                      padding: const EdgeInsets.only(right: 16, top: 4),
                      child: Chip(label: Text(genre)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          Text('${AppStrings.languages}:',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          const Chip(label: Text("En")),
          const SizedBox(
            height: 40,
          ),
          IconButtonWidget(
            color: Colors.black26,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateMovieScreen(
                    movie: movie,
                  ),
                ),
              );
            },
            label: "Edit Movie",
            icon: const Icon(
              Icons.edit,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          IconButtonWidget(
            color: Colors.red,
            onPressed: () {
              context
                  .read<MovieDetailBloc>()
                  .add(Invoke(params: DeleteMovieParam(movieId: movie.id)));
            },
            label: "Delete Movie",
            icon: const Icon(
              Icons.delete,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd MMM yyyy').format(parsedDate);
  }

  Widget _buildStarRating(double voteAverage) {
    if (voteAverage <= 5) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          if (index < voteAverage) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
              size: 40,
            );
          } else {
            return const Icon(Icons.star_border, color: Colors.amber, size: 40);
          }
        }),
      );
    } else {
      double adjustedRating = (voteAverage / 10) * 5;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          if (index < adjustedRating.floor()) {
            return const Icon(Icons.star, color: Colors.amber, size: 40);
          } else if (index < adjustedRating) {
            return const Icon(Icons.star_half, color: Colors.amber, size: 40);
          } else {
            return const Icon(Icons.star_border, color: Colors.amber, size: 40);
          }
        }),
      );
    }
  }
}
