import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:most_popular/src/data/datasource/local_data_source.dart';
import 'package:most_popular/src/data/datasource/remote_data_source.dart';
import 'package:most_popular/src/data/repository/most_popular_repository_impl.dart';
import 'package:most_popular/src/domain/entity/most_popular_response.dart';

import 'most_popular_domain_test.mocks.dart';

class MockPopularMovie extends Mock implements PopularMovie {
  @override
  String get title => "some_title";
}

class MockPopularResponse extends Mock implements MostPopularResponse {
  @override
  int get page => 1;

  @override
  List<IPopularMovie> get popularMovies => [MockPopularMovie()];
}

@GenerateMocks([MostPopularRemoteDatasource, MovieLocalDatasource])
void main() {
  group("PopularMovie:Domain Package Test", () {
    late MostPopularRemoteDatasource remoteDatasource;
    late MovieLocalDatasource localDatasource;
    late MostPopularRepository repository;

    setUp(() {
      localDatasource = MockMovieLocalDatasource();
      remoteDatasource = MockMostPopularRemoteDatasource();
      repository = MostPopularRepositoryImpl(
        remoteDataSource: remoteDatasource,
        localDatasource: localDatasource,
      );
    });

    test(
      'When getMovies is performed successfully, Then repository return a Right',
      () async {
        when(remoteDatasource.requestMostPopularMovies())
            .thenAnswer((_) async => MockPopularResponse());

        final data = await repository.getRemoteMovies();

        expect(data, isA<Right>());
        expect(data.getOrElse(() => []).first.title, "some_title");
      },
    );

    test(
      'When getMovies is performed, But Failure thrown, Then repository return a Left',
      () async {
        when(remoteDatasource.requestMostPopularMovies())
            .thenThrow(ParseFailure(message: "some_message"));

        final data = await repository.getRemoteMovies();

        expect(data, isA<Left>());
        expect(data.fold((l) => l, (_) => null)?.message, "some_message");
      },
    );
  });
}
