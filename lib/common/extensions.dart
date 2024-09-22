import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

extension PlatformExtension on BuildContext {
  bool isLandscape() {
    if (kIsWeb) {
      return true;
    } else if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      return MediaQuery.of(this).orientation == Orientation.landscape;
    }
    return false;
  }
}
