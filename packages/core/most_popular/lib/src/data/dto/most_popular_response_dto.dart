import 'package:most_popular/src/data/dto/popular_movie_dto.dart';
import 'package:most_popular/src/domain/entity/most_popular_response.dart';

class MostPopularResponseDto {
  final int page;
  final List<PopularMovieDto> popularMovies;
  final int totalPages;
  final int totalResults;

  MostPopularResponseDto({
    required this.page,
    required this.totalPages,
    required this.totalResults,
    required this.popularMovies,
  });

  factory MostPopularResponseDto.fromJson(Map<String, dynamic> json) =>
      MostPopularResponseDto(
        page: json["page"],
        popularMovies: List<PopularMovieDto>.from(
            (json["results"]).map((x) => PopularMovieDto.fromJson(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );

  IMostPopularResponse toDomain() => MostPopularResponse(
        page: page,
        totalResults: totalResults,
        totalPages: totalPages,
        popularMovies: popularMovies.map((e) => e.toDomain()).toList(),
      );
}
