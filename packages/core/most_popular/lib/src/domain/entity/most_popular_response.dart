import 'package:most_popular/most_popular_package.dart';

abstract class IMostPopularResponse {
  abstract final int page;
  abstract final int totalPages;
  abstract final int totalResults;
  abstract final List<IPopularMovie> popularMovies;
}

class MostPopularResponse implements IMostPopularResponse {
  @override
  final int page;
  @override
  final int totalPages;
  @override
  final int totalResults;
  @override
  final List<IPopularMovie> popularMovies;

  const MostPopularResponse({
    required this.page,
    required this.popularMovies,
    required this.totalPages,
    required this.totalResults,
  });
}
