import 'package:flutter/foundation.dart';

class AppLogger {
  static void info(String msg) => debugPrint('INFO: $msg');
  static void error(String msg) => debugPrint('ERROR: $msg');
  static void success(String msg) => debugPrint('SUCCESS: $msg');
}