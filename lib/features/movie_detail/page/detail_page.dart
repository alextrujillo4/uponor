import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:movie_challenge/common/extensions.dart';
import 'package:movie_challenge/common/widgets/loading_widget.dart';
import 'package:movie_challenge/common/widgets/problem_widget.dart';
import 'package:movie_challenge/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_challenge/features/movie_detail/widget/movie_detail_widget.dart';
import 'package:state_manager/state_manager.dart';

import '../../../di.dart';
import '../../popular_movies/bloc/popular_movies_bloc.dart';

class DetailPage extends StatelessWidget {
  final int _selectedMovieId;

  const DetailPage({
    super.key,
    required int selectedMovieId,
  }) : _selectedMovieId = selectedMovieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => sl<MovieDetailBloc>()
          ..add(Invoke(params: GetMovieParam(movieId: _selectedMovieId))),
        child: BlocConsumer<MovieDetailBloc, RequestState>(
          listener: (context, state) {
            if (state is SUCCESS<bool>) {
              sl<PopularMoviesBloc>().add(Invoke(
                params: const GetPopularMoviesParams(),
              ));
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is LOADING) {
              return LoadingWidget(message: state.message);
            } else if (state is ERROR) {
              return ProblemWidget(
                title: state.failure.toString(),
                message: state.failure.message,
                onTap: () {
                  context.read<MovieDetailBloc>().add(
                      Invoke(params: GetMovieParam(movieId: _selectedMovieId)));
                },
              );
            } else if (state is SUCCESS<IPopularMovie>) {
              return Center(
                child: ConstrainedBox(
                  constraints: context.isLandscape()
                      ? const BoxConstraints(maxWidth: 600)
                      : const BoxConstraints(),
                  child: MovieDetailWidget(
                    key: const ValueKey("detail_page"),
                    movie: state.data,
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
