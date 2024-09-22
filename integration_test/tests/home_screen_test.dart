import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_challenge/main.dart' as app;

import '../home_screen_tester.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group('Home Screen Test', () {
    setUp(() {
      app.main();
    });

    tearDown(() async {
      final getIt = GetIt.instance;
      await getIt.reset();
    });

    testWidgets(
      'When app starts ,Then MostPopular Page is Shown and GridIcon On',
      (WidgetTester tester) async {
        await tester.pumpAndSettle(const Duration(seconds: 5));
        final screen = HomeScreenTester(tester);

        await screen.clickMockMovie();

        expect(await screen.isGridOnIcon(), true);
        expect(await screen.isMostPopularPresent(), true);

        await tester.pumpAndSettle();
      },
      skip: false,
      timeout: const Timeout(Duration(minutes: 5)),
    );

    testWidgets(
      'When user clicks NewReleases ,Then MostPopularPage is Shown',
      (WidgetTester tester) async {
        await tester.pumpAndSettle(const Duration(seconds: 4));
        final screen = HomeScreenTester(tester);

        expect(await screen.isGridOnIcon(), true);

        await tester.pumpAndSettle();
      },
      skip: false,
      timeout: const Timeout(Duration(minutes: 5)),
    );

    testWidgets(
      'When user Click GridIcon for first time, Then GridIconOff is Shown',
      (WidgetTester tester) async {
        await tester.pumpAndSettle(const Duration(seconds: 4));
        final screen = HomeScreenTester(tester);

        await screen.clickGridView();
        expect(await screen.isGridOffIcon(), true);

        await tester.pumpAndSettle();
      },
      skip: false,
      timeout: const Timeout(Duration(minutes: 5)),
    );

    testWidgets(
      'When user Click a Movie, Then DetailPage is Shown',
      (WidgetTester tester) async {
        await tester.pumpAndSettle(const Duration(seconds: 4));
        final screen = HomeScreenTester(tester);

        await screen.clickFirstNewReleasesMoveInList();

        expect(await screen.isDetailPagePresent(), true);

        await tester.pump(const Duration(seconds: 1));

        await tester.pumpAndSettle();
      },
      skip: true,
      timeout: const Timeout(Duration(minutes: 5)),
    );
  });
}
