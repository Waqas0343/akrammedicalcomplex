import 'package:flutter/foundation.dart';

class Debug {
  static log(value) {
    if (kDebugMode) {
      print(value);
    }
  }
}

