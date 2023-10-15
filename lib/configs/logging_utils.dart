import 'package:logger/logger.dart';

class Logging {
  static final Logging _instance = Logging._internal();

  factory Logging() => _instance;

  Logging._internal();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      colors: true,
      methodCount: 1,
      errorMethodCount: 8,
      printTime: false,
    ),
  );

  Logger get logger => _logger;
}
