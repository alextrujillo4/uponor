import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:movie_challenge/common/app_strings.dart';
import 'package:movie_challenge/features/create_movie/bloc/create_movie_bloc.dart';
import 'package:movie_challenge/features/create_movie/widget/movie_form.dart';
import 'package:movie_challenge/features/popular_movies/bloc/popular_movies_bloc.dart';
import 'package:state_manager/state_manager.dart';

import '../../../di.dart';

class CreateMovieScreen extends StatelessWidget {
  final IPopularMovie? movie;

  const CreateMovieScreen({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateMovieBloc>(
      create: (context) => sl<CreateMovieBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(movie == null ? AppStrings.create : AppStrings.edit,
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        body: BlocConsumer<CreateMovieBloc, RequestState>(
          listener: (context, state) {
            if (state is SUCCESS<bool>) {
              sl<PopularMoviesBloc>().add(Invoke(
                params: const GetPopularMoviesParams(),
              ));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(movie == null
                        ? 'Movie created successfully!'
                        : 'Movie updated successfully!')),
              );
              Navigator.pop(context);
            } else if (state is ERROR) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed: ${state.failure.message}')),
              );
            }
          },
          builder: (context, state) {
            if (state is LOADING) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: MovieForm(movie: movie),
            );
          },
        ),
      ),
    );
  }
}
