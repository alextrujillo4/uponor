import 'dart:convert';

import 'package:cache/cache_package.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:most_popular/src/data/dto/popular_movie_dto.dart';

abstract class MovieLocalDatasource {
  Future<List<IPopularMovie>> getAll();

  Future<IPopularMovie> getById(int id);

  Future<bool> removeMovie(int id);

  Future<bool> saveMovie(PopularMovie movie);

  Future<bool> saveAll(List<PopularMovie> movies);

  Future<void> removeAll();

  Future<bool> updateMovie(PopularMovie movie);
}

class MovieLocalDatasourceImpl implements MovieLocalDatasource {
  static const String movieKEY = "MOVIE_KEY";
  static const int maxElements = 100;
  final Cache cache;

  MovieLocalDatasourceImpl({required this.cache});

  @override
  Future<void> removeAll() => cache.removeStringList(movieKEY);

  @override
  Future<bool> saveMovie(PopularMovie movie) async {
    List<PopularMovie> existingMovies = await _loadMovies();
    existingMovies.insert(0, movie);
    _ensureListMaxSize(existingMovies);
    List<String> dataToString = existingMovies.map((e) => e.toJson()).toList();
    return await cache.setStringList(movieKEY, dataToString);
  }

  @override
  Future<bool> removeMovie(int id) async {
    List<PopularMovie> existingMovies = await _loadMovies();
    existingMovies.removeWhere((element) => element.id == id);
    _ensureListMaxSize(existingMovies);
    List<String> dataToString = existingMovies.map((e) => e.toJson()).toList();
    return await cache.setStringList(movieKEY, dataToString);
  }

  @override
  Future<List<IPopularMovie>> getAll() async {
    return await _loadMovies();
  }

  @override
  Future<IPopularMovie> getById(int id) async {
    final existingMovies = await _loadMovies();
    final movie = existingMovies.firstWhere((movie) => movie.id == id,
        orElse: () => throw CacheFailure(
              message: 'Movie not found on local cache.',
              stacktrace: StackTrace.current,
            ));
    return movie;
  }

  @override
  Future<bool> saveAll(List<PopularMovie> movies) async {
    List<PopularMovie> existingMovies = await _loadMovies();

    existingMovies.insertAll(0, movies);

    _ensureListMaxSize(existingMovies);

    List<String> dataToString = existingMovies.map((e) => e.toJson()).toList();

    return await cache.setStringList(movieKEY, dataToString);
  }

  Future<List<PopularMovie>> _loadMovies() async {
    try {
      final encodedData = cache.getStringList(movieKEY);
      if (encodedData == null) return [];
      return encodedData
          .map((e) => PopularMovieDto.fromJson(json.decode(e)).toDomain())
          .toList();
    } catch (e, s) {
      throw ParseFailure(
        message: 'Error parsing Movie: $e',
        stacktrace: s,
      );
    }
  }

  @override
  Future<bool> updateMovie(PopularMovie movie) async {
    List<PopularMovie> existingMovies = await _loadMovies();
    final index = existingMovies
        .indexWhere((existingMovie) => existingMovie.id == movie.id);
    if (index != -1) {
      existingMovies[index] = movie;

      List<String> dataToString =
          existingMovies.map((e) => e.toJson()).toList();
      return await cache.setStringList(movieKEY, dataToString);
    } else {
      return false;
    }
  }

  void _ensureListMaxSize(List<IPopularMovie> list) {
    while (list.length > maxElements) {
      list.removeLast();
    }
  }
}
