import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:state_manager/state_manager.dart';

import 'failure.dart';

class PopularMoviesBloc extends StateManagement {
  final MostPopularRepository _repository;
  final SaveAllMovieUsecase _saveAllMovieUsecase;

  List<String> selectedFilters = [];

  PopularMoviesBloc({
    required MostPopularRepository repository,
    required SaveMovieUsecase saveMovieUsecase,
    required SaveAllMovieUsecase saveAllUseCase,
  })  : _repository = repository,
        _saveAllMovieUsecase = saveAllUseCase {
    on<Invoke<GetPopularMoviesParams>>(_getPopularMovies);
    on<Invoke<FilterByGenre>>(_filterBy);
  }

  _filterBy(Invoke<FilterByGenre> event, Emitter<RequestState> emit) async {
    try {
      final List<String> selectedFilters =
          event.params.selectedFilters.map((e) => e.toLowerCase()).toList();

      emit(LOADING());
      final failureOrSuccess = await _repository.getLocalMovies();

      return failureOrSuccess.fold(
        (failure) => emit(ERROR(failure: failure)),
        (popularMovies) {
          if (selectedFilters.isEmpty) {
            return emit(SUCCESS<List<IPopularMovie>>(data: popularMovies));
          } else {
            final filteredMovies = popularMovies.where((movie) {
              return movie.genres.any(
                  (genre) => selectedFilters.contains(genre.toLowerCase()));
            }).toList();

            return emit(SUCCESS<List<IPopularMovie>>(data: filteredMovies));
          }
        },
      );
    } catch (e, s) {
      final ex = PopularMoviesBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }

  _getPopularMovies(
      Invoke<GetPopularMoviesParams> event, Emitter<RequestState> emit) async {
    try {
      emit(LOADING());
      if (event.params.forceRemote) {
        await _repository.removeAll();
        return await _getRemoteMoviesAndSave(emit);
      }
      final failureOrSuccessLocal = await _repository.getLocalMovies();
      return failureOrSuccessLocal.fold(
        (failure) => emit(ERROR(failure: failure)),
        (localMovies) async =>
            emit(SUCCESS<List<IPopularMovie>>(data: localMovies)),
      );
    } catch (e, s) {
      final ex = PopularMoviesBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }

  Future<void> _getRemoteMoviesAndSave(Emitter<RequestState> emit) async {
    final failureOrSuccessRemote = await _repository.getRemoteMovies();
    return await failureOrSuccessRemote.fold(
      (failure) => emit(ERROR(failure: failure)),
      (remoteMovies) async {
        await _saveAllMovieUsecase(remoteMovies);
        return emit(SUCCESS<List<IPopularMovie>>(data: remoteMovies));
      },
    );
  }
}
