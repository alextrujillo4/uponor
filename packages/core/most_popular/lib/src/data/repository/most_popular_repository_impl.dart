import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:most_popular/src/data/datasource/local_data_source.dart';

import '../datasource/remote_data_source.dart';

class MostPopularRepositoryImpl extends ErrorHandler
    implements MostPopularRepository {
  final MostPopularRemoteDatasource _remoteDatasource;
  final MovieLocalDatasource _localDatasource;

  MostPopularRepositoryImpl(
      {required MovieLocalDatasource localDatasource,
      required MostPopularRemoteDatasource remoteDataSource})
      : _remoteDatasource = remoteDataSource,
        _localDatasource = localDatasource;

  @override
  Future<Either<Failure, List<IPopularMovie>>> getRemoteMovies() async =>
      handle<List<IPopularMovie>>(() async {
        final data = await _remoteDatasource.requestMostPopularMovies();
        return data.popularMovies;
      });

  @override
  Future<Either<Failure, List<IPopularMovie>>> getLocalMovies() async =>
      handle<List<IPopularMovie>>(() async => await _localDatasource.getAll());

  @override
  Future<Either<Failure, bool>> addMovie(PopularMovie movie) async =>
      handle<bool>(() async => await _localDatasource.saveMovie(movie));

  @override
  Future<Either<Failure, bool>> updateMovie(PopularMovie movie) async =>
      handle<bool>(() async => await _localDatasource.updateMovie(movie));

  @override
  Future<Either<Failure, bool>> addAll(List<PopularMovie> movie) async =>
      handle<bool>(() async => await _localDatasource.saveAll(movie));

  @override
  Future<Either<Failure, void>> removeAll() async =>
      handle<void>(() async => await _localDatasource.removeAll());

  @override
  Future<Either<Failure, bool>> deleteMovie(int id) async =>
      handle<bool>(() async => await _localDatasource.removeMovie(id));

  @override
  Future<Either<Failure, IPopularMovie>> getMovie(int id) async =>
      handle<IPopularMovie>(() async => await _localDatasource.getById(id));
}
