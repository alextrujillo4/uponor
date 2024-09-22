import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:most_popular/most_popular_package.dart';

abstract class MostPopularRepository {
  Future<Either<Failure, List<IPopularMovie>>> getRemoteMovies();

  Future<Either<Failure, List<IPopularMovie>>> getLocalMovies();

  Future<Either<Failure, IPopularMovie>> getMovie(int id);

  Future<Either<Failure, bool>> deleteMovie(int id);

  Future<Either<Failure, bool>> addMovie(PopularMovie movie);

  Future<Either<Failure, bool>> addAll(List<PopularMovie> movie);

  Future<Either<Failure, void>> removeAll();

  Future<Either<Failure, bool>> updateMovie(PopularMovie movie);
}
