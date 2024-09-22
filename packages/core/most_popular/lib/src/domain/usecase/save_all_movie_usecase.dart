import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:state_manager/state_manager.dart';

class UseCaseFailure extends Failure {
  UseCaseFailure({required super.message, super.stacktrace});
}

class SaveAllMovieUsecase implements UseCase<bool, List<IPopularMovie>> {
  final MostPopularRepository repository;

  const SaveAllMovieUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(List<IPopularMovie> movies) async {
    try {
      for (var movie in movies) {
        final result = await repository.addMovie(
          PopularMovie(
            id: movie.id,
            title: movie.title,
            genres: movie.genres,
            overview: movie.overview,
            popularity: movie.popularity,
            releaseDate: movie.releaseDate,
            voteAverage: movie.voteAverage,
            adult: movie.adult,
            originalLanguage: movie.originalLanguage,
            originalTitle: movie.originalTitle,
            posterPath: movie.posterPath,
            video: movie.video,
            voteCount: movie.voteCount,
          ),
        );

        if (result.isLeft()) {
          return result;
        }
      }
      return const Right(true);
    } catch (e) {
      return Left(UseCaseFailure(message: 'Failed to save all movies: $e'));
    }
  }
}
