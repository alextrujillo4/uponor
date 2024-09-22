import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  final SharedPreferences prefs;

  const Cache({required this.prefs});

// === String

  Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  String? getString(String key) {
    return prefs.getString(key);
  }

  Future<void> removeString(String key) async {
    await prefs.remove(key);
  }

  Future<bool> setStringList(String key, List<String> value) async =>
      await prefs.setStringList(key, value);

// === StringList
  List<String> getStringList(String key) => prefs.getStringList(key) ?? [];

  Future<void> removeStringList(String key) async => await prefs.remove(key);
}
