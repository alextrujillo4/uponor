import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:movie_challenge/features/create_movie/bloc/failure.dart';
import 'package:state_manager/state_manager.dart';

class CreateMovieBloc extends StateManagement {
  final SaveMovieUsecase _saveMovieUseCase;
  final UpdateMovieUsecase _updateMovieUsecase;

  CreateMovieBloc({
    required UpdateMovieUsecase updateMovieUsecase,
    required SaveMovieUsecase saveMovieUsecase,
  })  : _saveMovieUseCase = saveMovieUsecase,
        _updateMovieUsecase = updateMovieUsecase {
    on<Invoke<CreateMovieParam>>(_createMovie);
    on<Invoke<UpdateMovieParam>>(_updateMovie);
  }

  _createMovie(
      Invoke<CreateMovieParam> event, Emitter<RequestState> emit) async {
    try {
      final params = event.params;
      emit(LOADING(message: "Creating Movie"));
      final failureOrSuccess = await _saveMovieUseCase(params.movie);
      return failureOrSuccess.fold((failure) => emit(ERROR(failure: failure)),
          (isSuccess) => emit(SUCCESS<bool>(data: isSuccess)));
    } catch (e, s) {
      final ex = CreateMovieBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }

  _updateMovie(
      Invoke<UpdateMovieParam> event, Emitter<RequestState> emit) async {
    try {
      final params = event.params;
      emit(LOADING(message: "Updating Movie"));
      final failureOrSuccess = await _updateMovieUsecase(params.movie);
      return failureOrSuccess.fold((failure) => emit(ERROR(failure: failure)),
          (isSuccess) => emit(SUCCESS<bool>(data: isSuccess)));
    } catch (e, s) {
      final ex = CreateMovieBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }
}
