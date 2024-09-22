import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeScreenTester {
  late WidgetTester tester;

  HomeScreenTester(this.tester);

  final mockMovieBtn = find.byKey(const ValueKey("mock_movie_btn"));

  final nowMovieListElement = find.byKey(const ValueKey("movie_element_0"));

  final listViewBtn = find.byKey(const ValueKey("list_view_btn"));
  final gridOnIcon = find.byKey(const ValueKey("grid_on_icon"));
  final gridOffIcon = find.byKey(const ValueKey("grid_off_icon"));

  final popularPage = find.byKey(const ValueKey("popular_page"));
  final detailPage = find.byKey(const ValueKey("detail_page"));

  Future<void> clickGridView() async {
    await tester.tap(listViewBtn, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<bool> isGridOnIcon() async {
    return tester.any(gridOnIcon);
  }

  Future<bool> isGridOffIcon() async {
    return tester.any(gridOffIcon);
  }

  Future<void> clickSomeWhereInTheApp() async {
    await tester.tap(find.byType(AppBar), warnIfMissed: true);
  }

  Future<void> clickMockMovie() async {
    await tester.tap(mockMovieBtn, warnIfMissed: true);
  }

  Future<void> clickFirstNewReleasesMoveInList() async {
    await tester.tap(nowMovieListElement, warnIfMissed: true);
  }

  Future<bool> isMostPopularPresent() async {
    return tester.any(popularPage);
  }

  Future<bool> isDetailPagePresent() async {
    return tester.any(detailPage);
  }

  Future<bool> isNowMovieListElementPresent() async {
    return tester.any(nowMovieListElement);
  }
}
