import 'package:most_popular/src/data/dto/most_popular_response_dto.dart';
import 'package:most_popular/src/domain/entity/most_popular_response.dart';

import '../../domain/failure/failure.dart';
import 'mockedResponse.dart';

abstract class MostPopularRemoteDatasource {
  Future<IMostPopularResponse> requestMostPopularMovies();
}

class MostPopularRemoteDatasourceImpl implements MostPopularRemoteDatasource {
  const MostPopularRemoteDatasourceImpl();

  @override
  Future<IMostPopularResponse> requestMostPopularMovies() async {
    try {
      return MostPopularResponseDto.fromJson(mockedResponse).toDomain();
    } catch (e, s) {
      throw ParseFailure(
        message: 'Error parsing MovieDto: $e',
        stacktrace: s,
      );
    }
  }
}
