import 'package:flutter/material.dart';
import 'package:most_popular/most_popular_package.dart';

import '../../movie_detail/page/detail_page.dart';

class PopularMovieWidget extends StatelessWidget {
  const PopularMovieWidget({
    super.key,
    required this.movie,
    required this.position,
    required this.height,
  });

  final IPopularMovie movie;
  final int position;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPage(
              selectedMovieId: movie.id,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Image.network(
              movie.posterPath,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              height: height,
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "$position. ${movie.title}",
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    movie.overview,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16.0),
                  Chip(
                    label: Text(
                      'Release Date: ${movie.releaseDate}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
