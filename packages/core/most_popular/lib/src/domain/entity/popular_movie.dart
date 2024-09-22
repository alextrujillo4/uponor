import 'dart:convert';

abstract class IPopularMovie {
  bool get adult;

  String? get backdropPath;

  List<String> get genres;

  int get id;

  String get originalLanguage;

  String get originalTitle;

  String get overview;

  double get popularity;

  String get posterPath;

  String get releaseDate;

  String get title;

  bool get video;

  double get voteAverage;

  int get voteCount;
}

class PopularMovie implements IPopularMovie {
  @override
  final bool adult;
  @override
  final String? backdropPath;
  @override
  final List<String> genres;
  @override
  final int id;
  @override
  final String originalLanguage;
  @override
  final String originalTitle;
  @override
  final String overview;
  @override
  final double popularity;
  @override
  final String posterPath;
  @override
  final String releaseDate;
  @override
  final String title;
  @override
  final bool video;
  @override
  final double voteAverage;
  @override
  final int voteCount;

  PopularMovie({
    required this.adult,
    this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genres': genres,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  String toJson() => jsonEncode(toMap());
}
