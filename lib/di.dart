import 'package:get_it/get_it.dart';
import 'package:movie_challenge/features/create_movie/bloc/create_movie_bloc.dart';
import 'package:movie_challenge/features/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_challenge/features/popular_movies/bloc/popular_movies_bloc.dart';

import 'common/settings_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton<SettingsProvider>(SettingsProvider());

  sl.registerSingleton(PopularMoviesBloc(
      repository: sl(), saveMovieUsecase: sl(), saveAllUseCase: sl()));

  sl.registerFactory<MovieDetailBloc>(() => MovieDetailBloc(repository: sl()));

  sl.registerFactory<CreateMovieBloc>(
      () => CreateMovieBloc(saveMovieUsecase: sl(), updateMovieUsecase: sl()));
}
