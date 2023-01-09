import 'package:logger/logger.dart';

final logger = Logger();

dynamic logDebugMessage({required String message}) {
  logger.d(message);
}
