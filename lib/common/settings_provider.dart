import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isListView = true;

  bool get isListView => _isListView;


  set isListView(bool value) {
    _isListView = value;
    notifyListeners();
  }

  set selectedLanguage(String value) {
    notifyListeners();
  }
}
