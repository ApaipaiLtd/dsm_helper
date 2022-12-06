import 'package:flutter/foundation.dart';
import 'package:simple_logger/simple_logger.dart';

class Log {
  static SimpleLogger logger = SimpleLogger();
  static init() {
    logger.levelPrefixes = {};
    logger.mode = LoggerMode.log;
    logger.setLevel(kDebugMode ? Level.ALL : Level.OFF, includeCallerInfo: true);
  }
}
