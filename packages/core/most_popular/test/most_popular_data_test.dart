import 'package:flutter_test/flutter_test.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:most_popular/src/data/datasource/remote_data_source.dart';

void main() {
  group('MostPopularRemoteDatasourceImpl Tests', () {
    late MostPopularRemoteDatasourceImpl datasource;

    setUp(() {
      datasource = MostPopularRemoteDatasourceImpl();
    });

    /**
     * This test focuses only on one scenario of JSON parsing with mockedResponse.
     * It exemplifies how a test works with predefined data, without involving
     * real network requests or extensive scenario coverage.
     */

    test(
        'should return a List<IPopularMovie> when parsing is successful using mockedResponse',
        () async {
      final result = await datasource.requestMostPopularMovies();

      expect(result.popularMovies, isA<List<IPopularMovie>>());
      expect(result.page, 1);
      expect(result.popularMovies.first.id, 533535);
      expect(result.popularMovies.first.originalTitle, "Deadpool & Wolverine");
    });
  });
}
