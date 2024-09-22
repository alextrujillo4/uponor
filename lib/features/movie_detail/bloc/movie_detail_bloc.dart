import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:state_manager/state_manager.dart';

import 'failure.dart';

class MovieDetailBloc extends StateManagement {
  final MostPopularRepository _repository;

  MovieDetailBloc({
    required MostPopularRepository repository,
  }) : _repository = repository {
    on<Invoke<GetMovieParam>>(_getMovieFromId);
    on<Invoke<DeleteMovieParam>>(_removeFromFavorites);
  }

  _getMovieFromId(
      Invoke<GetMovieParam> event, Emitter<RequestState> emit) async {
    try {
      final movieId = event.params.movieId;
      emit(LOADING(message: "Obteniendo detalles"));
      final failureOrSuccess = await _repository.getMovie(movieId);
      return failureOrSuccess.fold((failure) => emit(ERROR(failure: failure)),
          (movies) => emit(SUCCESS<IPopularMovie>(data: movies)));
    } catch (e, s) {
      final ex = DetailBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }

  _removeFromFavorites(
      Invoke<DeleteMovieParam> event, Emitter<RequestState> emit) async {
    try {
      final params = event.params.movieId;
      emit(LOADING(message: "Removiendo favorito"));
      final failureOrSuccess = await _repository.deleteMovie(params);
      return failureOrSuccess.fold((failure) => emit(ERROR(failure: failure)),
          (isFavorite) => emit(SUCCESS<bool>(data: !isFavorite)));
    } catch (e, s) {
      final ex = DetailBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }
}
