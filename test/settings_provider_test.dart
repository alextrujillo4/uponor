import 'package:flutter_test/flutter_test.dart';
import 'package:movie_challenge/common/settings_provider.dart';

void main() {
  group('SettingsProvider', () {
    test('Set isListView', () {
      final settingsProvider = SettingsProvider();

      settingsProvider.isListView = false;
      expect(settingsProvider.isListView, false);

      settingsProvider.isListView = true;
      expect(settingsProvider.isListView, true);
    });
  });
}
