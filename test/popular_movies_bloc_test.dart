import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:movie_challenge/features/popular_movies/bloc/popular_movies_bloc.dart';
import 'package:state_manager/state_manager.dart';

class MockPopularResponse extends Mock implements IPopularMovie {
  @override
  int get id => 1;

  @override
  String get title => "A Mocked movie";

  @override
  String get overview => "This is a mocked movie";

  @override
  String get posterPath => "https://some-url.com";

  @override
  double get voteAverage => 8.0;

  @override
  String get releaseDate => "2022-12-12";

  @override
  List<String> get genres => ["Action", "Adventure"];
}

class MockMostPopularRepository extends Mock implements MostPopularRepository {
  @override
  Future<Either<Failure, List<IPopularMovie>>> getRemoteMovies() async {
    return Right([MockPopularResponse()]);
  }

  @override
  Future<Either<Failure, void>> removeAll() async {
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<IPopularMovie>>> getLocalMovies() async {
    return Right([MockPopularResponse()]);
  }
}

class MockErrorMostPopularRepository extends Mock
    implements MostPopularRepository {
  @override
  Future<Either<Failure, List<IPopularMovie>>> getRemoteMovies() async {
    return Left(ApiCallFailure(
        message: "some_message", stacktrace: StackTrace.current));
  }

  @override
  Future<Either<Failure, void>> removeAll() async {
    return const Right(null);
  }
}

class MockSaveAllMovieUsecase extends Mock implements SaveAllMovieUsecase {
  @override
  Future<Either<Failure, bool>> call(List<IPopularMovie> movies) async {
    return const Right(true);
  }
}

class MockSaveMovieUsecase extends Mock implements SaveMovieUsecase {
  @override
  Future<Either<Failure, bool>> call(IPopularMovie movie) async {
    return const Right(true);
  }
}

void main() {
  /**
   * This test is created for the specific scenario:
   * GetPopularMoviesParams(forceRemote: true).
   *
   * Additional scenarios and comprehensive tests are not included here,
   * as this is just an example to demonstrate understanding of
   * how bloc tests function.
   *
   * In a real-world scenario, all edge cases and failure paths
   * would be properly tested.
   */

  group('PopularMoviesBloc Tests', () {
    final successCallRepository = MockMostPopularRepository();
    final saveAllMovieUsecase = MockSaveAllMovieUsecase();
    final saveMovieUsecase = MockSaveMovieUsecase();

    blocTest<PopularMoviesBloc, RequestState>(
      'emits [LOADING, SUCCESS], when Invoke(NoParams) is Success',
      build: () => PopularMoviesBloc(
        repository: successCallRepository,
        saveAllUseCase: saveAllMovieUsecase,
        saveMovieUsecase: saveMovieUsecase,
      ),
      act: (bloc) => bloc
          .add(Invoke(params: const GetPopularMoviesParams(forceRemote: true))),
      expect: () => [
        isA<LOADING>(),
        isA<SUCCESS<List<IPopularMovie>>>().having(
          (event) => event.data.first.title,
          "title",
          "A Mocked movie",
        )
      ],
    );

    final errorCallRepository = MockErrorMostPopularRepository();

    blocTest<PopularMoviesBloc, RequestState>(
      'emits [LOADING, ERROR], when Invoke(NoParams) is Error',
      build: () => PopularMoviesBloc(
        repository: errorCallRepository,
        saveAllUseCase: saveAllMovieUsecase,
        saveMovieUsecase: saveMovieUsecase,
      ),
      act: (bloc) => bloc
          .add(Invoke(params: const GetPopularMoviesParams(forceRemote: true))),
      expect: () => [
        isA<LOADING>(),
        isA<ERROR>().having(
          (event) => event.failure.message,
          "message",
          "some_message",
        )
      ],
    );
  });
}
