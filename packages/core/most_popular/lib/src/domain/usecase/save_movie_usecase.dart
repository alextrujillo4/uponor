import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:state_manager/state_manager.dart';

class SaveMovieUsecase implements UseCase<bool, PopularMovie> {
  final MostPopularRepository repository;

  const SaveMovieUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(IPopularMovie movie) async {
    return await repository.addMovie(
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
  }
}
