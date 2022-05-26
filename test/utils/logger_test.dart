import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test Logger', () {
    test('log error', () {
      logger.v("verbose message");
      logger.d("debug message");
      logger.i("info message");
      logger.w("warning message");
      logger.e("error message");
      logger.log("full message");
      logger.log("full message", printFullText: true);
      logger.log("full message", stackTrace: StackTrace.empty);
    });
  });
}
