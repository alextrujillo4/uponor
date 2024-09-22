import 'package:get_it/get_it.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:most_popular/src/data/datasource/local_data_source.dart';
import 'package:most_popular/src/data/datasource/remote_data_source.dart';
import 'package:most_popular/src/data/repository/most_popular_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<MostPopularRemoteDatasource>(
      () => const MostPopularRemoteDatasourceImpl());

  sl.registerFactory<MovieLocalDatasource>(
      () => MovieLocalDatasourceImpl(cache: sl()));

  sl.registerFactory<SaveMovieUsecase>(() => SaveMovieUsecase(sl()));
  sl.registerFactory<UpdateMovieUsecase>(() => UpdateMovieUsecase(sl()));
  sl.registerFactory<SaveAllMovieUsecase>(() => SaveAllMovieUsecase(sl()));

  sl.registerFactory<MostPopularRepository>(
    () => MostPopularRepositoryImpl(
        remoteDataSource: sl(), localDatasource: sl()),
  );
}
